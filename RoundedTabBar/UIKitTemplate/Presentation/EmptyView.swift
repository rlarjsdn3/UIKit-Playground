//
//  EmptyView.swift
//  UIKitTemplate
//
//  Created by 김건우 on 5/10/25.
//

import UIKit

final class EmptyView: UIView {
    
    convenience init() {
        self.init(frame: .zero)
        self.backgroundColor = .clear
    }
}
