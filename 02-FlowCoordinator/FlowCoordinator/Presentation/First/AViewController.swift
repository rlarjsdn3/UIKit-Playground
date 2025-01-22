//
//  AViewController.swift
//  FlowCoordinator
//
//  Created by 김건우 on 1/22/25.
//

import UIKit

protocol AViewControllerProtocol: AnyObject {
    var goToB: (() -> Void)? { get set }
    var onProfile: (() -> Void)? { get set }
}

class AViewController: UIViewController, AViewControllerProtocol {
    
    // MARK: - AViewControllerProtocol
    
    var goToB: (() -> Void)?
    var onProfile: (() -> Void)?
    
    // MARK: - Vars & Lets
    
    var viewModel: AViewModelProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Action
    
    @IBAction func goToB(_ sender: Any) {
        self.goToB?()
    }
    
    @IBAction func profile(_ sender: Any) {
        self.onProfile?()
    }
    
}
