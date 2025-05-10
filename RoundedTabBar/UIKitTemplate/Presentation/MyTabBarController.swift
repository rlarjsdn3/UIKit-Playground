//
//  MyTabBarController.swift
//  UIKitTemplate
//
//  Created by 김건우 on 4/4/25.
//

import UIKit

class MyTabBarController: UITabBarController {
    
    let myTabBar = MyTabBar()

    var myTabBarItems: [MyTabBarItem] = [] {
        didSet { myTabBar.set(myTabBarItems) }
    }
    
    override var selectedIndex: Int {
        didSet { myTabBar.setSelctedTab(selectedIndex) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        configureTabBarItems()
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
            self.myTabBarItems = items.enumerated().map {
                MyTabBarItem(
                    title: $1.title ?? "",
                    image: $1.image,
                    selectedImage: $1.selectedImage,
                    index: $0
                )
            }
            selectedIndex = 0
        }
    }
}

extension MyTabBarController: MyTabBarDelegate {
    
    func tabBar(_ tabBar: MyTabBar, didSelect button: MyTabBarItem, at index: Int) {
        selectedIndex = index
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
    return tabBarController
}
