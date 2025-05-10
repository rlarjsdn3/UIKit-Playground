//
//  MyTabBar.swift
//  UIKitTemplate
//
//  Created by 김건우 on 5/10/25.
//

import UIKit

@MainActor
protocol MyTabBarDelegate: AnyObject {
    func tabBar(_ tabBar: MyTabBar, didSelect button: MyTabBarItem, at index: Int)
}

// TODO: 버튼을 정확히 동일한 스페이스를 주면서 배치하기
// UIStackView 사용 X, 임의로 배치하거나 - Stackview trailing이나 leading 조정

// TODO: Path 및 애니메이션 추가하기

final class MyTabBar: UIView {
    
    private let stackView = UIStackView()
    private var tabBarItems: [MyTabBarItem] = []
    
    private var circleViewCenterConstraints: NSLayoutConstraint?
    // TODO: - 원형 뷰를 첫번쨰 지점에 위치시키기
    private let circle = Circle() // tint 설정 코드 작성
    private let curvedShape = CurvedShape()
    weak var delegate: (any MyTabBarDelegate)?
    
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
        applyCurvedShapeMask()
    }

    private func setupUI() {
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.22
        self.layer.shadowRadius = 10
        
        // 마스킹될 컨테이너 뷰 추가
        // 처음 아이콘 중간에, 클릭하면 위로 올리기
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        self.addSubview(circle)
        circle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circle.widthAnchor.constraint(equalToConstant: 10),
            circle.heightAnchor.constraint(equalToConstant: 10),
            circle.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 10)
        ])
    }

    private func applyCurvedShapeMask() {
        let maskLayer = CAShapeLayer()
        maskLayer.path = curvedShape.createShapeLayer(for: self.bounds, midX: 0).path
        maskLayer.fillColor = UIColor.black.cgColor
        maskLayer.frame = self.bounds
        self.layer.mask = maskLayer
    }
    
    @objc private func handleTabBarItemTap(_ sender: MyTabBarItem) {
        delegate?.tabBar(self, didSelect: sender, at: sender.tag)
        
        let selectedIndex = sender.tag
        let targetOffsetX = self.tabBarItems[selectedIndex].center.x
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut) {
            self.circle.center.x = targetOffsetX
            self.curvedShape.center.x = targetOffsetX
            self.tabBarItems[selectedIndex].transform = CGAffineTransform(translationX: 0, y: -10)
        }
        
        // 코드 리팩토링하기
        for item in tabBarItems where item !== sender {
            UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut) {
                item.transform = .identity
            }
        }
        self.animateMaskPath(to: targetOffsetX)
    }
        
        
        // ✅ 마스킹 경로 애니메이션 메서드
        func animateMaskPath(to midX: CGFloat) {
            guard let maskLayer = self.layer.mask as? CAShapeLayer else { return }
            
            let fromPath = maskLayer.path
            let toPath = curvedShape.createShapeLayer(for: self.bounds, midX: midX).path
            
            // ✅ Path 애니메이션 생성
            let animation = CABasicAnimation(keyPath: "path")
            animation.fromValue = fromPath
            animation.toValue = toPath
            animation.duration = 0.25
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            // ✅ 애니메이션 적용
            maskLayer.add(animation, forKey: "pathAnimation")
            maskLayer.path = toPath  // 최종 상태 유지
        }
}

extension MyTabBar {
    
    func setSelctedTab(_ selectedIndex: Int) {
        tabBarItems.forEach { item in
            item.applySelectionState(selectedIndex)
        }
    }
    
    func set(_ items: [MyTabBarItem]) {
        for item in items {
            item.addTarget(self, action: #selector(handleTabBarItemTap), for: .touchUpInside)
        }
        self.tabBarItems = items // 코드 리팩토링
        stackView.replaceArrangedSubviews(items)
    }
}
