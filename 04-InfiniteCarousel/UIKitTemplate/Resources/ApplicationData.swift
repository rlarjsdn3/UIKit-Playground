//
//  ApplicationData.swift
//  UIKitTemplate
//
//  Created by 김건우 on 4/4/25.
//

import UIKit

struct ApplicationData {
    let items: [UIColor]
    
    init() {
        items = [.systemRed, .systemOrange, .systemYellow]
    }
}
let appData = ApplicationData()
