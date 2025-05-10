//
//  MyCollectionViewCell.swift
//  UIKitTemplate
//
//  Created by 김건우 on 5/8/25.
//

import UIKit

final class MyCollectionViewCell: UICollectionViewCell {
    static let id = NSStringFromClass(MyCollectionViewCell.self)

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.transform = .identity
    }

    func transformToLarge() {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }
    }

    func transformToStandard() {
        UIView.animate(withDuration: 0.2) {
            self.transform = .identity
        }
    }
}
