//
//  MainCoordinator.swift
//  FlowCoordinator
//
//  Created by 김건우 on 1/22/25.
//

import Foundation

final class MainCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    
    // MARK: - CoordinatorFinishOutput
    
    var finishFlow: (() -> Void)?
    
    // MARK: - Vars & Lets
    
    private let router: any RouterProtocol
    private let coordinatorFactory: any CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory
    
    // MARK: - Private methods
    
    private func showAViewController() {
        let aVC = self.viewControllerFactory.instantiateAViewContoller()
        aVC.goToB = { [weak self] in
            self?.showBViewController()
        }
        aVC.onProfile = { [weak self] in
            self?.showProfile()
        }
        self.router.setRootModule(aVC, hideBar: true)
    }
    
    private func showBViewController() {
        let bVC = self.viewControllerFactory.instantiateBViewContoller()
        bVC.backToA = { [weak self] in
            self?.router.popModule()
        }
        bVC.onLogout = { [weak self] in
            self?.finishFlow?()
        }
        self.router.push(bVC)
    }
    
    private func showProfile() {
        let coordinator = self.coordinatorFactory.makeProfileCoordinatorBox(router: self.router, coordinatorFactory: self.coordinatorFactory, viewControllerFactory: self.viewControllerFactory)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.router.popModule()
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    // MARK: - Coordinator
    
    override func start() {
        self.showAViewController()
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
