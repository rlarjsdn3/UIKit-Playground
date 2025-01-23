//
//  ChangePasswordStep1ViewController.swift
//  FlowCoordinator
//
//  Created by 김건우 on 1/22/25.
//

import UIKit

protocol ChangePasswordStep1ViewControllerProtocol: AnyObject {
    var onNextStep: (() -> Void)? { get set }
    var onBack: (() -> Void)? { get set }
}

class ChangePasswordStep1ViewController: UIViewController,  ChangePasswordStep1ViewControllerProtocol {
    
    // MARK: - ChangePasswordStep1ViewControllerProtocol
    
    var onNextStep: (() -> Void)?
    var onBack: (() -> Void)?
    
    // MARK: - Vars & Lets
    
    var viewModel: ChangePasswordStep1ViewModel?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func nextStep(_ sender: Any) {
        self.onNextStep?()
    }
    
    @IBAction func back(_ sender: Any) {
        self.onBack?()
    }
}
