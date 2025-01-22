//
//  ProfileCoordinator.swift
//  FlowCoordinator
//
//  Created by 김건우 on 1/22/25.
//

import Foundation

final class ProfileCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    
    // MARK: - CoordinatorFinishOutput
    
    var finishFlow: (() -> Void)?
    
    // MARK: - Vars & Lets
    
    private let router: any RouterProtocol
    private let coordinatorFactory: any CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory
    
    // MARK: - Private methods
    
    private func showProfileViewController() {
        let profileVC = self.viewControllerFactory.instantiateProfileViewController()
        profileVC.onBack = { [weak self] in
            self?.finishFlow?()
        }
        profileVC.onChangePassword = { [weak self, weak profileVC] in
            self?.showChangePasswordViewController(module: profileVC!)
        }
        self.router.push(profileVC)
    }
    
    private func showChangePasswordViewController(module: ProfileViewController) {
        let coordinator = self.coordinatorFactory.makeChangePasswordCoordinatorBox(router: router, viewControllerFactory: viewControllerFactory)
        coordinator.finishFlow = { [weak self, weak module, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.router.popToModule(module: module, animated: true)
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    // MARK: - Coordinator
    
    override func start() {
        self.showProfileViewController()
    }
    
    // MARK: - Init
    
    init(router: any RouterProtocol, coordinatorFactory: any CoordinatorFactoryProtocol, viewControllerFactory: ViewControllerFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory
    }
    
}
