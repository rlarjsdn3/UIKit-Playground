//
//  Colors.swift
//  UIKitTemplate
//
//  Created by 김건우 on 5/8/25.
//

import UIKit

let colors = [
    "#FA4F79",
    "#FC676B",
    "#FF6844",
    "#FA975C",
    "#FDA84B",
    "#FDA84B",
    "#EDC32B",
    "#EDD70E",
    "#C3CB16",
    "#A2C41F",
    "#8BCD1F",
    "#8BCD1F",
    "#25C43F",
    "#30CF7A",
    "#4AE6AC",
    "#3BEABC",
    "#25DCBC",
    "#25CDBE",
    "#4AE2DF",
    "#30D2DC",
    "#02A7BE",
    "#30B4D4",
    "#2DBAEE",
    "#54B4FE",
    "#97BEFF",
    "#90A2FE",
    "#C3BCFC",
    "#DBC5FE",
    "#CD82FA",
    "#E885F9",
    "#FF42F8",
    "#FA5ADA",
    "#FF97DA",
    "#FB89C1",
    "#FBA5C3"
]

extension UIColor {

    convenience init?(_ hex:String) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        if cString.count != 6 {
            return nil
        }
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        let red   = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue  = CGFloat(rgbValue & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: CGFloat(1.0))
    }
}
