//
//  WalkthroughViewModel.swift
//  FlowCoordinator
//
//  Created by 김건우 on 1/22/25.
//

import UIKit

protocol WalkthroughViewControllerProtocol: AnyObject {
    var onFinish: (() -> Void)? { get set }
}

class WalkthroughViewController: UIViewController, WalkthroughViewControllerProtocol {
    
    // MARK: - WalkthroughViewControllerProtocol
    
    var onFinish: (() -> Void)?
    
    // MARK: - Vars & Lets
    
    var viewModel: WalkthroughViewModel?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func finish(_ sender: Any) {
        self.onFinish?()
    }
}
