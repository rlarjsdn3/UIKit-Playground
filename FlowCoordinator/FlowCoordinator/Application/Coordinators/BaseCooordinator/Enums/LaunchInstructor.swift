//
//  LaunchInstructor.swift
//  FlowCoordinator
//
//  Created by 김건우 on 1/22/25.
//

import Foundation

fileprivate var onboardingWasShown = false
fileprivate var isAuthorized = false

enum LaunchInstructor {
    
    case main
    case auth
    case onboarding
    
    // MARK: - Public methods
    
    static func configure(tutorialWasShown: Bool = onboardingWasShown,
                          isAuthorized: Bool = isAuthorized) -> LaunchInstructor {
        
        switch (tutorialWasShown, isAuthorized) {
        case (true, false), (false, false): return .auth
        case (false, true): return .onboarding
        case (true, true): return .main
        }
    }
    
}
