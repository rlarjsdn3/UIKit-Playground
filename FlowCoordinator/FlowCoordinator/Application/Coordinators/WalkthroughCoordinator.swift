//
//  WalkthroughCoordinator.swift
//  FlowCoordinator
//
//  Created by 김건우 on 1/22/25.
//

import Foundation

final class WalkthroughCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    
    // MARK: - CoordinatorFinishOutput
    
    var finishFlow: (() -> Void)?
    
    // MARK: - Vars & Lets
    
    private let router: RouterProtocol
    private let viewControllerFactory: ViewControllerFactory
    
    // MARK: - Private methods
    
    private func showWalkthroughViewController() {
        let walkthroughVC = self.viewControllerFactory.instantiateWalkthroughViewController()
        walkthroughVC.onFinish = { [weak self] in
            self?.finishFlow?()
        }
        self.router.setRootModule(walkthroughVC, hideBar: true)
    }
    
    // MARK: - Coordinator
    
    override func start() {
        self.showWalkthroughViewController()
    }
    
    // MARK: - Init
    
    init(router: RouterProtocol, viewControllerFactory: ViewControllerFactory) {
        self.router = router
        self.viewControllerFactory = viewControllerFactory
    }
}
