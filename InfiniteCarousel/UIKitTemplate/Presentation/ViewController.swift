//
//  ViewController.swift
//  UIKitTemplate
//
//  Created by 김건우 on 4/4/25.
//

import UIKit

class ViewController: UIViewController {
    
    
    // MARK: - Properties
    
    private var dataSource: [UIColor] = []
    private var didSetInitialOffset = false
    
    private var collectionView: UICollectionView!

    
    // MARK: - Intializer
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupData()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !didSetInitialOffset {
            let width = view.bounds.width
            collectionView.setContentOffset(
                CGPoint(x: width * 1, y: 0),
                animated: false
            )
        }
    }
    
    // MARK: - Private
    
    private func setupUI() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: view.bounds.width, height: 300)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .zero
        collectionView.backgroundColor = nil
        
        collectionView.register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.id)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 120),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        self.collectionView = collectionView
    }
    
    private func setupData() {
        dataSource.append(appData.items.last!)
        dataSource.append(contentsOf: appData.items)
        dataSource.append(appData.items.first!)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CarouselCell.id,
            for: indexPath) as? CarouselCell
        else {
            return .init()
        }
        
        let index = indexPath.row
        cell.update(dataSource[index], String(index))
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let count = CGFloat(dataSource.count)
        let width = view.bounds.width
        let contentOffsetX = scrollView.contentOffset.x
        
        // 0번째 셀로 드래그를 한다면
        if contentOffsetX == 0 {
            // 3번째 셀로 이동하기
            scrollView.setContentOffset(
                CGPoint(x: width * (count - 2), y: 0),
                animated: false)
        }
        
        // 4번째 셀로 드래그를 한다면
        if contentOffsetX == width * (count - 1) {
            // 1번째 셀로 이동하기
            scrollView.setContentOffset(
                CGPoint(x: width, y: 0),
                animated: false)
        }
    }
}
