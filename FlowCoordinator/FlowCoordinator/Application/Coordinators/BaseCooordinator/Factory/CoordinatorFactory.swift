//
//  CoordinatorFactory.swift
//  FlowCoordinator
//
//  Created by 김건우 on 1/22/25.
//

import Foundation

protocol CoordinatorFactoryProtocol {
    func makeAuthCoordinatorBox(router: RouterProtocol,
                                coordinatorFactory: CoordinatorFactoryProtocol,
                                viewControllerFactory: ViewControllerFactory) -> AuthCoordinator
    func makeChangePasswordCoordinatorBox(router: RouterProtocol,
                                          viewControllerFactory: ViewControllerFactory) -> ChangePasswordCoordinator
    func makeMainCoordinatorBox(router: RouterProtocol,
                                coordinatorFactory: CoordinatorFactoryProtocol,
                                viewControllerFactory: ViewControllerFactory) -> MainCoordinator
    func makeWalktroughCoordinatorBox(router: RouterProtocol,
                                      viewControllerFactory: ViewControllerFactory) -> WalkthroughCoordinator
    func makeProfileCoordinatorBox(router: RouterProtocol,
                                   coordinatorFactory: CoordinatorFactoryProtocol,
                                   viewControllerFactory: ViewControllerFactory) -> ProfileCoordinator
}

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    
    // MARK: - CoordinatorFactoryProtocol
    
    func makeAuthCoordinatorBox(router: RouterProtocol,
                                coordinatorFactory: CoordinatorFactoryProtocol,
                                viewControllerFactory: ViewControllerFactory) -> AuthCoordinator {
        let coordinator = AuthCoordinator(router: router, coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
        return coordinator
    }
    
    func makeChangePasswordCoordinatorBox(router: RouterProtocol,
                                          viewControllerFactory: ViewControllerFactory) -> ChangePasswordCoordinator {
        let coordinator = ChangePasswordCoordinator(router: router, viewControllerFactory: viewControllerFactory)
        return coordinator
    }
    
    func makeMainCoordinatorBox(router: RouterProtocol,
                                coordinatorFactory: CoordinatorFactoryProtocol,
                                viewControllerFactory: ViewControllerFactory) -> MainCoordinator {
        let coordinator = MainCoordinator(router: router, coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
        return coordinator
    }
    
    func makeWalktroughCoordinatorBox(router: RouterProtocol,
                                      viewControllerFactory: ViewControllerFactory) -> WalkthroughCoordinator {
        let coordinator = WalkthroughCoordinator(router: router, viewControllerFactory: viewControllerFactory)
        return coordinator
    }
    
    func makeProfileCoordinatorBox(router: RouterProtocol,
                                   coordinatorFactory: CoordinatorFactoryProtocol,
                                   viewControllerFactory: ViewControllerFactory) -> ProfileCoordinator {
        let coordinator = ProfileCoordinator(router: router, coordinatorFactory: coordinatorFactory, viewControllerFactory: viewControllerFactory)
        return coordinator
    }
    
}
