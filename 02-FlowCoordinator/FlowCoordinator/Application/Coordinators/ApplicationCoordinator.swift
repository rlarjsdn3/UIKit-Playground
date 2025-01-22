//
//  ApplicationCoordinator.swift
//  FlowCoordinator
//
//  Created by 김건우 on 1/22/25.
//

import Foundation

final class ApplicationCoordinator: BaseCoordinator {
    
    // MARK: - Vars & Lets
    
    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let viewControllerFactory: ViewControllerFactory = ViewControllerFactory()
    private var launchInstructor = LaunchInstructor.configure()
    
    // MARK: - Coordinator
    
    override func start(with option: DeepLinkOption?) {
        if option != nil {
            
        } else {
            switch launchInstructor {
            case .main: runMainFlow()
            case .auth: runAuthFlow()
            case .onboarding: runOnboardingFlow()
            }
        }
    }
    
    // MARK: - Private methods
    
    private func runAuthFlow() {
        let coordinator = self.coordinatorFactory.makeAuthCoordinatorBox(router: router, coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.launchInstructor = LaunchInstructor.configure(tutorialWasShown: false, isAuthorized: true)
            self?.start()
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    private func runMainFlow() {
        let coordinator = self.coordinatorFactory.makeMainCoordinatorBox(router: router, coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.launchInstructor = LaunchInstructor.configure(tutorialWasShown: false, isAuthorized: false)
            self?.start()
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    private func runOnboardingFlow() {
        let coordinator = self.coordinatorFactory.makeWalktroughCoordinatorBox(router: router, viewControllerFactory: viewControllerFactory)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.launchInstructor = LaunchInstructor.configure(tutorialWasShown: true, isAuthorized: true)
            self?.start()
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    // MARK: - Init
    
    init(router: any RouterProtocol,
         coordinatorFactory: any CoordinatorFactoryProtocol) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
}
