//
//  UICollectionView+Ext.swift
//  PlaceBook
//
//  Created by 김건우 on 1/14/25.
//

import UIKit

extension UICollectionView {
    
    func cellForItem<Cell>(at indexPath: IndexPath) -> Cell? where Cell: UICollectionViewCell {
        return cellForItem(at: indexPath) as? Cell
    }
}
