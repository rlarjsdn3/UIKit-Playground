//
//  RegisterViewController.swift
//  FlowCoordinator
//
//  Created by 김건우 on 1/22/25.
//

import UIKit

protocol RegisterViewControllerProtocol: AnyObject {
    var onRegister: (() -> Void)? { get set }
    var onBack: (() -> Void)? { get set }
}

class RegisterViewController: UIViewController, RegisterViewControllerProtocol {
    
    // MARK: - RegisterViewControllerProtocol
    
    var onRegister: (() -> Void)?
    var onBack: (() -> Void)?
    
    // MARK: - Vars & Lets
    
    var viewModel: RegisterViewModel?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func register(_ sender: Any) {
        self.onRegister?()
    }
    
    @IBAction func back(_ sender: Any) {
        self.onBack?()
    }
}
