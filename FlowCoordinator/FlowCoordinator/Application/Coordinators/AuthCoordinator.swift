//
//  AuthCoordinator.swift
//  FlowCoordinator
//
//  Created by 김건우 on 1/22/25.
//

import Foundation

final class AuthCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    
    // MARK: - CoordinatorFinishOutput
    
    var finishFlow: (() -> Void)?
    
    // MARK: - Vars & Lets
    
    private let router: any RouterProtocol
    private let coordinatorFactory: any CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory
    
    // MARK: - Private methods
    
    private func showLoginViewController() {
        let loginVC = self.viewControllerFactory.instantiateLoginViewController()
        loginVC.onLogin = { [weak self] in
            self?.finishFlow?()
        }
        loginVC.onRegister = { [weak self] in
            self?.showRegisterViewController()
        }
        loginVC.onChangePassword = { [weak self, weak loginVC] in
            self?.showChangePassword(module: loginVC!)
        }
        self.router.setRootModule(loginVC, hideBar: true)
    }
    
    private func showRegisterViewController() {
        let registerVC = self.viewControllerFactory.instantiateRegisterViewController()
        registerVC.onBack = { [weak self] in
            self?.router.popModule()
        }
        registerVC.onRegister = { [weak self] in
            self?.router.popModule()
        }
        self.router.push(registerVC)
    }
    
    private func showChangePassword(module: LoginViewController) {
        let coordinator = self.coordinatorFactory.makeChangePasswordCoordinatorBox(router: router, viewControllerFactory: viewControllerFactory)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.router.popToModule(module: module, animated: true)
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    // MARK: - Coordinator
    
    override func start() {
        self.showLoginViewController()
    }
    
    // MARK: - Init
    
    init(router: any RouterProtocol,
         coordinatorFactory: any CoordinatorFactoryProtocol,
         viewControllerFactory: ViewControllerFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory
    }
    
}
