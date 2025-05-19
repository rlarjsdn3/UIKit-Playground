//
//  MyTabBar.swift
//  UIKitTemplate
//
//  Created by 김건우 on 5/10/25.
//

import UIKit

@MainActor
protocol MyTabBarDelegate: AnyObject {
    //
    func tabBar(_ tabBar: MyTabBar, didSelect item: MyTabBarItem, at index: Int)
    //
    func tabBar(_ tabBar: MyTabBar, refresh items: [MyTabBarItem])
}

final class MyTabBar: UIView {

    private let container = UIView()
    private let stackView = UIStackView()
    // 
    private var tabBarItems: [MyTabBarItem] = [] {
        didSet { self.layoutIfNeeded() }
    }

    private let circle = Circle()
    private let wavyBottom = WavyBottomShape()

    weak var delegate: (any MyTabBarDelegate)?

    override var tintColor: UIColor? {
        didSet { updateTintColor() }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // `layoutSubviews`에서 마스킹을 적용하는 것은
    // 동적인 레이아웃 환경에서 마스킹이 항상 올바르게 유지되도록 보장하기 위함입니다.
    override func layoutSubviews() {
        super.layoutSubviews()

        if let first = tabBarItems.first {
            applyWavyBottomMask(first.center.x)
            animateCircle(to: first.center.x, withDuration: 0)
        }
    }

    private func setupUI() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.22
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize(width: 5, height: 5)

        self.addSubview(container)
        container.backgroundColor = .systemBackground
        container.layer.cornerRadius = 20
        container.layer.masksToBounds = false
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])

        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            stackView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
        ])

        self.addSubview(circle)
        circle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circle.widthAnchor.constraint(equalToConstant: 10),
            circle.heightAnchor.constraint(equalToConstant: 10),
            circle.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 10)
        ])
    }

    @objc private func handleTabBarItemTap(_ sender: MyTabBarItem) {
        delegate?.tabBar(self, didSelect: sender, at: sender.tag)

        let selectedIndex = sender.tag
        let targetOffsetX = self.tabBarItems[selectedIndex].center.x
        animate(selectedIndex, to: targetOffsetX)

        //
        for item in tabBarItems where item !== sender {
            animateTabBarItem(item.tag, to: 0)
        }
    }

    private func applyWavyBottomMask(_ offsetX: CGFloat) {
        //
        let maskLayer = CAShapeLayer()
        maskLayer.path = wavyBottom.createPath(self.bounds, offsetX: offsetX).cgPath
        maskLayer.fillColor = UIColor.black.cgColor
        maskLayer.frame = self.bounds
        //
        container.layer.mask = maskLayer
    }

    func animateIntialState() {
        if let firstItem = tabBarItems.first {
            let selectedIndex = 0
            let targetOffsetX = firstItem.center.x
            animate(selectedIndex, to: targetOffsetX, withDuration: 0.0)
        }
    }

    private func animate(
        _ selectedIndex: Int,
        to targetOffset: CGFloat,
        withDuration duration: TimeInterval = 0.25
    ) {
        animateTabBarItem(selectedIndex, withDuration: duration)
        animateCircle(to: targetOffset, withDuration: duration)
        animateWavyBottom(to: targetOffset, withDuration: duration)
    }

    private func animateTabBarItem(
        _ selectedIndex: Int,
        to offsetY: CGFloat = -10,
        withDuration duration: TimeInterval = 0.25
    ) {
        UIView.animate(withDuration: duration) {
            self.tabBarItems[selectedIndex].transform = CGAffineTransform(translationX: 0, y: offsetY)
        }
    }

    private func animateCircle(
        to targetOffsetX: CGFloat,
        withDuration duration: TimeInterval = 0.25
    ) {
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut) {
            self.circle.center.x = targetOffsetX
        }
    }

    // Layer와 관련된 애니메이션은 모두 CAAnimation으로 해야 한다는 점을 기억하세요!
    private func animateWavyBottom(
        to targetOffsetX: CGFloat,
        withDuration duration: TimeInterval = 0.25
    ) {
        guard let maskLayer = container.layer.mask as? CAShapeLayer else { return }

        let fromPath = maskLayer.path
        let toPath = wavyBottom.createPath(self.bounds, offsetX: targetOffsetX).cgPath

        //
        let animation = CABasicAnimation(keyPath: "path")
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.fromValue = fromPath
        animation.toValue = toPath
        animation.duration = duration

        maskLayer.add(animation, forKey: "pathAnimation")
        maskLayer.path = toPath
    }

    private func updateTintColor() {
        circle.tintColor = tintColor
        tabBarItems.forEach { $0.tint = tintColor }
        // 아이템의 강조 색상 프로퍼티만 수정할 경우, UI에 즉시 반영되지 않으므로,
        // 현재 selectedIndex를 기반으로 버튼을 다시 로드하여 강조 색상을 업데이트합니다.
        delegate?.tabBar(self, refresh: tabBarItems)
    }
}

extension MyTabBar {

    //
    func setSelctedTab(_ selectedIndex: Int) {
        tabBarItems.forEach { item in
            item.applySelectionState(selectedIndex)
        }
    }

    //
    func setTabBarItems(_ items: [MyTabBarItem]) {
        tabBarItems = items
        for item in items {
            item.addTarget(
                self,
                action: #selector(handleTabBarItemTap),
                for: .touchUpInside
            )
        }
        stackView.replaceArrangedSubviews(items)
    }

    //
    func reloadTabBarItem(_ selectedIndex: Int) {
        tabBarItems[selectedIndex].applySelectionState(selectedIndex)
    }
}
