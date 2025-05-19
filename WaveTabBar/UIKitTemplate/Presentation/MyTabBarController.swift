//
//  MyTabBarController.swift
//  UIKitTemplate
//
//  Created by 김건우 on 4/4/25.
//

import UIKit

class MyTabBarController: UITabBarController {
    
    let myTabBar = MyTabBar()

    private var myTabBarItems: [MyTabBarItem] = [] {
        didSet { myTabBar.setTabBarItems(myTabBarItems) }
    }

    override var selectedIndex: Int {
        didSet { myTabBar.setSelctedTab(selectedIndex) }
    }

    override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        configureTabBarItems()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myTabBar.animateIntialState()
    }
    
    private func setupUI() {
        self.tabBar.isHidden = true
        view.addSubview(myTabBar)

        myTabBar.delegate = self
        myTabBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            myTabBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            myTabBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30),
            myTabBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            myTabBar.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    private func configureTabBarItems() {
        if let items = viewControllers?.compactMap(\.tabBarItem) {
            // Stack에 아이템을 모두 추가하여 렌더링한 후,
            // selectedIndex를 지정해야 강조 색상이 올바르게 반영됩니다.
            myTabBarItems = items.enumerated().map {
                MyTabBarItem(
                    title: $1.title ?? "",
                    image: $1.image,
                    selectedImage: $1.selectedImage,
                    tint: myTabBar.tintColor,
                    tag: $0
                )
            }
            selectedIndex = 0
        }
    }
}

extension MyTabBarController: MyTabBarDelegate {
    
    func tabBar(_ tabBar: MyTabBar, didSelect items: MyTabBarItem, at index: Int) {
        selectedIndex = index
    }

    func tabBar(_ tabBar: MyTabBar, refresh items: [MyTabBarItem]) {
        // 강조 색상이 변경될 경우, 현재 선택된 아이템을 다시 로드하여
        // 강조 색상이 올바르게 반영되도록 합니다.
        if let selectedIndex = items.firstIndex(where: { $0 === myTabBarItems[selectedIndex] }) {
            myTabBar.reloadTabBarItem(selectedIndex)
        }
    }
}

#Preview {
    let firstViewController = FirstViewController()
    firstViewController.tabBarItem = UITabBarItem(
        title: nil,
        image: UIImage(systemName: "house"),
        selectedImage: UIImage(systemName: "house.fill")
    )
    let secondViewController = SecondViewController()
    secondViewController.tabBarItem = UITabBarItem(
        title: nil,
        image: UIImage(systemName: "star"),
        selectedImage: UIImage(systemName: "star.fill")
    )
    let thirdViewController = ThirdViewController()
    thirdViewController.tabBarItem = UITabBarItem(
        title: nil,
        image: UIImage(systemName: "magnifyingglass"),
        selectedImage: UIImage(systemName: "magnifyingglass")
    )
    let fourthViewController = ThirdViewController()
    fourthViewController.tabBarItem = UITabBarItem(
        title: nil,
        image: UIImage(systemName: "gear"),
        selectedImage: UIImage(systemName: "gear.fill")
    )
    let tabBarController = MyTabBarController()
    tabBarController.setViewControllers(
        [firstViewController, secondViewController, thirdViewController, fourthViewController],
        animated: false
    )
    tabBarController.myTabBar.tintColor = .systemRed
    return tabBarController
}
