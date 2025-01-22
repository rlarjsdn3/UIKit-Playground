//
//  CoordinatorFactory.swift
//  FlowCoordinator
//
//  Created by 김건우 on 1/22/25.
//

import UIKit

class ViewControllerFactory {
    
    func instantiateLoginViewController() -> LoginViewController {
        let loginVC = UIStoryboard.auth.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        loginVC.viewModel = LoginViewModel()
        return loginVC
    }
    
    func instantiateRegisterViewController() -> RegisterViewController {
        let registerVC = UIStoryboard.auth.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        registerVC.viewModel = RegisterViewModel()
        return registerVC
    }
    
    func instantiateChangePasswordStep1ViewController() -> ChangePasswordStep1ViewController {
        let step1VC = UIStoryboard.changePassword.instantiateViewController(identifier: "ChangePasswordStep1ViewController") as! ChangePasswordStep1ViewController
        step1VC.viewModel = ChangePasswordStep1ViewModel()
        return step1VC
    }
    
    func instantiateChangePasswordStep2ViewController() -> ChangePasswordStep2ViewController {
        let step2VC = UIStoryboard.changePassword.instantiateViewController(identifier: "ChangePasswordStep2ViewController") as! ChangePasswordStep2ViewController
        step2VC.viewModel = ChangePasswordStep2ViewModel()
        return step2VC
    }
    
    func instantiateWalkthroughViewController() -> WalkthroughViewController {
        let walkthroughVC = UIStoryboard.walkthrough.instantiateViewController(withIdentifier: "WalkthroughViewController") as! WalkthroughViewController
        walkthroughVC.viewModel = WalkthroughViewModel()
        return walkthroughVC
    }
    
    func instantiateAViewContoller() -> AViewController {
        let aVC = UIStoryboard.first.instantiateViewController(withIdentifier: "AViewController") as! AViewController
        aVC.viewModel = AViewModel()
        return aVC
    }
    
    func instantiateBViewContoller() -> BViewController {
        let bVC = UIStoryboard.first.instantiateViewController(withIdentifier: "BViewController") as! BViewController
        bVC.viewModel = BViewModel()
        return bVC
    }
    
    func instantiateProfileViewController() -> ProfileViewController {
        let profileVC = UIStoryboard.profile.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        profileVC.viewModel = ProfileViewModel()
        return profileVC
    }
}

