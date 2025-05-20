//
//  MyTabBar.swift
//  UIKitTemplate
//
//  Created by 김건우 on 5/10/25.
//

import UIKit

@MainActor
protocol MyTabBarDelegate: AnyObject {
    /// <#Description#>
    /// - Parameters:
    ///   - tabBar: <#tabBar description#>
    ///   - item: <#item description#>
    ///   - index: <#index description#>
    func tabBar(
        _ tabBar: MyTabBar,
        didSelect item: MyTabBarItem,
        at index: Int
    )
}

final class MyTabBar: UIView {

    private let container = UIView()
    private let stackView = UIStackView()
    
    /// <#Description#>
    private var tabBarItems: [MyTabBarItem] = [] {
        didSet { self.layoutIfNeeded() }
    }
    
    /// <#Description#>
    private let circle = Circle()
    
    /// <#Description#>
    private let wavyBottom = Wavy()
    
    /// <#Description#>
    weak var delegate: (any MyTabBarDelegate)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        #warning("탭뷰가 hidden되었다가 다시 보일 때, 버튼 위치가 이상해지는 문제 수정")
        // 탭뷰가 사라질 때 layoutsubviews가 한번 호출됨
        // 다시 나타날 때도 또 호출되고 
        print(#function)
        if let first = tabBarItems.first {
            applyWavyBottomMask(first.center.x)
            animateCircle(to: first.center.x, withDuration: 0)
        }
//        animateIntialState()
    }
    
    /// <#Description#>
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
    
    /// <#Description#>
    /// - Parameter sender: <#sender description#>
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
    
    /// <#Description#>
    /// - Parameter offsetX: <#offsetX description#>
    private func applyWavyBottomMask(_ offsetX: CGFloat) {
        //
        let maskLayer = CAShapeLayer()
        maskLayer.path = wavyBottom.createPath(self.bounds, offsetX: offsetX).cgPath
        maskLayer.fillColor = UIColor.black.cgColor
        maskLayer.frame = self.bounds
        //
        container.layer.mask = maskLayer
    }
}

extension MyTabBar {
    
    /// <#Description#>
    func animateIntialState() {
        if let firstItem = tabBarItems.first {
            let selectedIndex = 0
            let targetOffsetX = firstItem.center.x
            animate(selectedIndex, to: targetOffsetX, withDuration: 0.0)
            applyWavyBottomMask(targetOffsetX)
        }
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - selectedIndex: <#selectedIndex description#>
    ///   - targetOffset: <#targetOffset description#>
    ///   - duration: <#duration description#>
    private func animate(
        _ selectedIndex: Int,
        to targetOffset: CGFloat,
        withDuration duration: TimeInterval = 0.25
    ) {
        animateTabBarItem(selectedIndex, withDuration: duration)
        animateCircle(to: targetOffset, withDuration: duration)
        animateWavyBottom(to: targetOffset, withDuration: duration)
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - selectedIndex: <#selectedIndex description#>
    ///   - offsetY: <#offsetY description#>
    ///   - duration: <#duration description#>
    private func animateTabBarItem(
        _ selectedIndex: Int,
        to offsetY: CGFloat = -10,
        withDuration duration: TimeInterval = 0.25
    ) {
        UIView.animate(withDuration: duration) {
            self.tabBarItems[selectedIndex].transform = CGAffineTransform(translationX: 0, y: offsetY)
        }
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - targetOffsetX: <#targetOffsetX description#>
    ///   - duration: <#duration description#>
    private func animateCircle(
        to targetOffsetX: CGFloat,
        withDuration duration: TimeInterval = 0.25
    ) {
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut) {
            self.circle.center.x = targetOffsetX
        }
    }

    /// <#Description#>
    /// - Parameters:
    ///   - targetOffsetX: <#targetOffsetX description#>
    ///   - duration: <#duration description#>
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
}

extension MyTabBar {

    /// <#Description#>
    func updateTintColor(_ tintColor: UIColor) {
        circle.tintColor = tintColor
        tabBarItems.forEach { $0.setTintColor(tintColor) }
    }

    /// <#Description#>
    /// - Parameter selectedIndex: <#selectedIndex description#>
    func updateSelctedTab(_ selectedIndex: Int) {
        tabBarItems.forEach { item in
            item.applySelectionState(selectedIndex)
        }
    }
    
    /// <#Description#>
    /// - Parameter items: <#items description#>
    func updateTabBarItems(_ items: [MyTabBarItem]) {
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

    /// <#Description#>
    /// - Parameter selectedIndex: <#selectedIndex description#>
    func reloadTabBarItem(_ selectedIndex: Int) {
        tabBarItems[selectedIndex].applySelectionState(selectedIndex)
    }
}
