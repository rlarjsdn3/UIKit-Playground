//
//  ViewController.swift
//  PlaceBook
//
//  Created by 김건우 on 1/14/25.
//

import UIKit

final class ImageGalleryViewController: UICollectionViewController {

    // MARK: - Properties
    
    var selectedCell: PhotoCell?
    
    
    // MARK: - init
    
    convenience init() {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    // MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAttributes()
    }
    
    func setupAttributes() {
        view.backgroundColor = .systemBackground
        
        collectionView.backgroundColor = .systemBackground
        collectionView.delaysContentTouches = false
        collectionView.register(PhotoCell.self,
                                forCellWithReuseIdentifier: PhotoCell.id)
        collectionView.setCollectionViewLayout(createBasicListLayout(),
                                               animated: false)
    }
    
    // MARK: - Private
    
    private func createBasicListLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalWidth(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: itemSize.heightDimension)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                     subitems: [item, item])
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 7
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}


// MARK: - Extensions

extension ImageGalleryViewController {
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return AppData.photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoCell.id,
            for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: AppData.photos[indexPath.item])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        let vc = ImageDetailViewController()
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .custom
        vc.item = AppData.photos[indexPath.item]
        selectedCell = collectionView.cellForItem(at: indexPath)
        present(vc, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didHighlightItemAt indexPath: IndexPath) {
        guard let cell: PhotoCell = collectionView.cellForItem(at: indexPath) else { return }
        cell.adjustScale(to: 0.95)
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didUnhighlightItemAt indexPath: IndexPath) {
        guard let cell: PhotoCell = collectionView.cellForItem(at: indexPath) else { return }
        cell.adjustScale(to: 1.0)
    }
}

extension ImageGalleryViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        return ImageDetailPresentAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        guard let _ = dismissed as? ImageDetailViewController else {
            return nil
        }
        return ImageDetailDismissalAnimator()
    }
}
