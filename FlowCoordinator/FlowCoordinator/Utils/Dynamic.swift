//
//  Dynamic.swift
//  FlowCoordinator
//
//  Created by 김건우 on 1/22/25.
//

import Foundation

class Dynamic<T> {
    
    // MARK: - Typealias
    
    typealias Listener = (T) -> Void
    
    // MARK: - Vars & Lets
    
    var listener: Listener?
    var value: T {
        didSet { self.fire() }
    }
    
    // MARK: - Intialization
    
    init(_ v: T) {
        value = v
    }
    
    // MARK: - Public func
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    // MARK: - Internal func
    
    internal func fire() {
        self.listener?(value)
    }
}
