//
//  ChangePasswordStep2ViewController.swift
//  FlowCoordinator
//
//  Created by 김건우 on 1/22/25.
//

import UIKit

protocol ChangePasswordStep2ViewControllerProtocol: AnyObject {
    var onResetPassword: (() -> Void)? { get set }
    var onBack: (() -> Void)? { get set }
}

class ChangePasswordStep2ViewController: UIViewController, ChangePasswordStep2ViewControllerProtocol {
    
    // MARK: - ChangePasswordStep2ViewControllerProtocol
    
    var onResetPassword: (() -> Void)?
    var onBack: (() -> Void)?
    
    // MARK: - Vars & Lets
    
    var viewModel: ChangePasswordStep2ViewModel?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func resetPassword(_ sender: Any) {
        self.onResetPassword?()
    }
    
    @IBAction func back(_ sender: Any) {
        self.onBack?()
    }
}
