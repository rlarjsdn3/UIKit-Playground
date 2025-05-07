//
//  ChangePasswordCoordinator.swift
//  FlowCoordinator
//
//  Created by 김건우 on 1/22/25.
//

import Foundation

final class ChangePasswordCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    
    // MARK: - CoordinatorFinishOutput
    
    var finishFlow: (() -> Void)?
    
    // MARK: - Vars & Lets
    
    private let router: any RouterProtocol
    private let viewControllerFactory: ViewControllerFactory
    
    // MARK: - Private methods
    
    private func showChangePasswordStep1() {
        let step1VC = self.viewControllerFactory.instantiateChangePasswordStep1ViewController()
        step1VC.onBack = { [weak self] in
            self?.finishFlow?()
        }
        step1VC.onNextStep = { [weak self] in
            self?.showChangePasswordStep2()
        }
        self.router.push(step1VC)
    }
    
    private func showChangePasswordStep2() {
        let step2VC = self.viewControllerFactory.instantiateChangePasswordStep2ViewController()
        step2VC.onBack = { [weak self] in
            self?.router.popModule()
        }
        step2VC.onResetPassword = { [weak self] in
            self?.finishFlow?()
        }
        self.router.push(step2VC)
    }
    
    // MARK: - Coordinator
    
    override func start() {
        self.showChangePasswordStep1()
    }
    
    // MARK: - Init
    
    init(router: any RouterProtocol,
         viewControllerFactory: ViewControllerFactory) {
        self.router = router
        self.viewControllerFactory = viewControllerFactory
    }
}
