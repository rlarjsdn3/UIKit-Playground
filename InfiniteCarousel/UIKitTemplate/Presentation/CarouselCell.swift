//
//  CarouselCell.swift
//  UIKitTemplate
//
//  Created by 김건우 on 4/4/25.
//

import UIKit

final class CarouselCell: UICollectionViewCell {
    
    // MARK: - ID
    
    static let id = NSStringFromClass(CarouselCell.self)
    
    // MARK: - Properties
    
    private let bgView = UIView()
    private let numberLabel = UILabel()
    
    // MARK: - Intializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Update
    
    override func prepareForReuse() {
        super.prepareForReuse()
        update(nil, nil)
    }
    
    func update(_ color: UIColor?, _ text: String?) {
        numberLabel.text = text
        bgView.backgroundColor = color
    }
    
    // MARK: - Private
    
    private func setupUI() {
        contentView.addSubview(bgView)
        contentView.addSubview(numberLabel)
        
        bgView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bgView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
}
