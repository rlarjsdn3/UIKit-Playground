//
//  BViewController.swift
//  FlowCoordinator
//
//  Created by 김건우 on 1/22/25.
//

import UIKit

protocol BViewControllerProtocol: AnyObject {
    var backToA: (() -> Void)? { get set }
    var onLogout: (() -> Void)? { get set }
}

class BViewController: UIViewController, BViewControllerProtocol {
    
    // MARK: - AViewControllerProtocol
    
    var backToA: (() -> Void)?
    var onLogout: (() -> Void)?
    
    // MARK: - Vars & Lets
    
    var viewModel: BViewModelProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Action
    
    @IBAction func backToA(_ sender: Any) {
        self.backToA?()
    }
    
    @IBAction func logout(_ sender: Any) {
        self.onLogout?()
    }
    
}
