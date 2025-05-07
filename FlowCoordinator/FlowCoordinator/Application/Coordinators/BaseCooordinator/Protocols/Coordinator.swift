//
//  Coordinator.swift
//  FlowCoordinator
//
//  Created by 김건우 on 1/22/25.
//

import Foundation

protocol Coordinator: AnyObject {
    func start()
    func start(with option: DeepLinkOption?)
}


