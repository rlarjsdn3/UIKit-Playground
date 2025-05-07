//
//  LoginViewController.swift
//  FlowCoordinator
//
//  Created by 김건우 on 1/22/25.
//

import UIKit

protocol LoginViewControllerProtocol: AnyObject {
    var onLogin: (() -> Void)? { get set }
    var onRegister: (() -> Void)? { get set }
    var onChangePassword: (() -> Void)? { get set }
}

class LoginViewController: UIViewController, LoginViewControllerProtocol {
    
    // MARK: - LoginViewControllerProtocol
    
    var onLogin: (() -> Void)?
    var onRegister: (() -> Void)?
    var onChangePassword: (() -> Void)?
    
    // MARK: - Vars & Lets
    
    var viewModel: LoginViewModelProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func login(_ sender: Any) {
        self.onLogin?()
    }
    
    @IBAction func register(_ sender: Any) {
        self.onRegister?()
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        self.onChangePassword?()
    }
}

