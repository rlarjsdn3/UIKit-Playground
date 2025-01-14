//
//  PhotoCell.swift
//  PlaceBook
//
//  Created by 김건우 on 1/14/25.
//

import UIKit

final class PhotoCell: UICollectionViewCell {
    
    // MARK: - ID
    
    static let id = NSStringFromClass(PhotoCell.self)
    
    
    // MARK: - Views
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        return image
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.numberOfLines = 1
        title.font = .boldSystemFont(ofSize: 24)
        title.textAlignment = .center
        title.textColor = .white
        return title
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.addSubview(titleLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    func configure(with item: Item) {
        titleLabel.text = item.title
        imageView.image = UIImage(named: item.image)
    }
    
    func adjustScale(to scale: CGFloat) {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransformMakeScale(scale, scale)
        }
    }
}

extension PhotoCell {
    func getImageView() -> UIImageView {
        return imageView
    }
}
