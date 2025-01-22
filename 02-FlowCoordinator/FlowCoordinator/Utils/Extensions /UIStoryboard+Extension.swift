//
//  UIStoryboard+Extension.swift
//  FlowCoordinator
//
//  Created by 김건우 on 1/22/25.
//

import UIKit

extension UIStoryboard {
    
    // MARK: - Vars & Lets
    
    static var first: UIStoryboard {
        return UIStoryboard(name: "First", bundle: nil)
    }
    
    static var auth: UIStoryboard {
        return UIStoryboard(name: "Auth", bundle: nil)
    }
    
    static var changePassword: UIStoryboard {
        return UIStoryboard(name: "ChangePassword", bundle: nil)
    }
    
    static var walkthrough: UIStoryboard {
        return UIStoryboard(name: "Walkthrough", bundle: nil)
    }
    
    static var profile: UIStoryboard {
        return UIStoryboard(name: "Profile", bundle: nil)
    }
}
