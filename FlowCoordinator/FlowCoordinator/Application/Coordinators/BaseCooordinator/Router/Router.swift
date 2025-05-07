//
//  Router.swift
//  FlowCoordinator
//
//  Created by 김건우 on 1/22/25.
//

import UIKit

protocol RouterProtocol: Presentable {
    
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)
    
    func push(_ module: Presentable?)
    func push(_ module: Presentable?, transition: (any UIViewControllerAnimatedTransitioning)?)
    func push(_ module: Presentable?, transition: (any UIViewControllerAnimatedTransitioning)?, animated: Bool)
    func push(_ module: Presentable?, transition: (any UIViewControllerAnimatedTransitioning)?, animated: Bool, completion: (() -> Void)?)
    
    func popModule()
    func popModule(transition: (any UIViewControllerAnimatedTransitioning)?)
    func popModule(transition: (any UIViewControllerAnimatedTransitioning)?, animated: Bool)
    
    func dismissModule()
    func dismissModule(animated: Bool, completion: (() -> Void)?)
    
    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideBar: Bool)
    
    func popToRootModule(animated: Bool)
    func popToModule(module: Presentable?, animated: Bool)
}

final class Router: NSObject, RouterProtocol {
    
    // MARK: - Vars & Lets
    
    private weak var rootViewController: UINavigationController?
    
    /// 뷰 컨트롤러가 팝될 때 호출되는 클로저를 저장하는 딕셔너리
    private var completions: [UIViewController: ()->Void]
    
    /// 뷰 컨트롤러가 푸시나 팝될 때 수행할 전환 애니메이션 객체
    private var transition: (any UIViewControllerAnimatedTransitioning)?
    
    // MARK: - Presentable
    
    func toPresent() -> UIViewController? {
        self.rootViewController
    }
    
    // MARK: - RouterProtocol
    
    func present(_ module: (any Presentable)?) {
        present(module, animated: true)
    }
    
    func present(_ module: (any Presentable)?,
                 animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        self.rootViewController?.present(controller, animated: animated)
    }
    
    func push(_ module: (any Presentable)?) {
        self.push(module, transition: nil)
    }
    
    func push(_ module: (any Presentable)?,
              transition: (any UIViewControllerAnimatedTransitioning)?) {
        self.push(module, transition: transition, animated: true)
    }
    
    func push(_ module: (any Presentable)?,
              transition: (any UIViewControllerAnimatedTransitioning)?,
              animated: Bool) {
        self.push(module, transition: transition, animated: animated, completion: nil)
    }
    
    func push(_ module: (any Presentable)?,
              transition: (any UIViewControllerAnimatedTransitioning)?,
              animated: Bool,
              completion: (() -> Void)?) {
        guard let controller = module?.toPresent(),
              (controller is UINavigationController == false) else {
            assertionFailure("can NOT push UINavigationController.")
            return
        }
        
        if let completion = completion {
            self.completions[controller] = completion
        }
        
        self.rootViewController?.pushViewController(controller, animated: animated)
    }
    
    func popModule() {
        self.popModule(transition: nil)
    }
    
    func popModule(transition: (any UIViewControllerAnimatedTransitioning)?) {
        self.popModule(transition: transition, animated: true)
    }
    
    func popModule(transition: (any UIViewControllerAnimatedTransitioning)?,
                   animated: Bool) {
        self.transition = transition
        if let controller = rootViewController?.popViewController(animated: animated) {
            self.runCompletion(for: controller)
        }
    }
    
    func popToModule(module: (any Presentable)?,
                     animated: Bool) {
        if let controllers = self.rootViewController?.viewControllers, let module = module {
            for controller in controllers {
                if controller == module as! UIViewController {
                    self.rootViewController?.popToViewController(controller, animated: animated)
                    break
                }
            }
        }
    }
    
    func dismissModule() {
        self.dismissModule(animated: true, completion: nil)
    }
    
    func dismissModule(animated: Bool,
                       completion: (() -> Void)?) {
        self.rootViewController?.dismiss(animated: animated, completion: completion)
    }
    
    func setRootModule(_ module: (any Presentable)?) {
        self.setRootModule(module, hideBar: false)
    }
    
    func setRootModule(_ module: (any Presentable)?,
                       hideBar: Bool) {
        guard let controller = module?.toPresent() else { return }
        self.rootViewController?.setViewControllers([controller], animated: false)
        self.rootViewController?.isNavigationBarHidden = hideBar
    }
    
    func popToRootModule(animated: Bool) {
        if let controllers = self.rootViewController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                self.runCompletion(for: controller)
            }
        }
    }
    
    // MARK: - Private methods
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = self.completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
    
    // MARK: - Init methods
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
        self.completions = [:]
        super.init()
        self.rootViewController?.delegate = self
    }
}

// MARK: - Extensions
// MARK: - UINavigationControllerDelegate

extension Router: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        return self.transition
    }
}
