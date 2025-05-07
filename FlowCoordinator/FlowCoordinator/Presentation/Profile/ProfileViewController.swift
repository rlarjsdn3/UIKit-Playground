//
//  ProfileViewController.swift
//  FlowCoordinator
//
//  Created by 김건우 on 1/22/25.
//

import UIKit

protocol ProfileViewControllerProtocol: AnyObject {
    var onChangePassword: (() -> Void)? { get set }
    var onBack: (() -> Void)? { get set }
}

class ProfileViewController: UIViewController,  ProfileViewControllerProtocol {
    
    // MARK: - ProfileViewControllerProtocol
    
    var onChangePassword: (() -> Void)?
    var onBack: (() -> Void)?
    
    // MARK: - Vars & Lets
    
    var viewModel: ProfileViewModel?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func chagePassword(_ sender: Any) {
        self.onChangePassword?()
    }
    
    @IBAction func back(_ sender: Any) {
        self.onBack?()
    }
}
