//
//  ViewController.swift
//  UIKitTemplate
//
//  Created by 김건우 on 4/4/25.
//

import UIKit

class ViewController: UIViewController {

    private lazy var collectionView = {
        return UICollectionView(
            frame: .zero,
            collectionViewLayout: myCollectionViewFlowLayout
        )
    }()
    private let myCollectionViewFlowLayout = MyColletionViewFlowLayout()
    private var centerCell: MyCollectionViewCell?
    private var enableHapticFeedback = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupAttributes()
    }

    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupAttributes() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.id)
        collectionView.showsHorizontalScrollIndicator = false

        // 컬렉션 뷰의 왼쪽과 오른쪽 외부 여백(margins)을 합산하여 계산합니다.
        let layoutMargins: CGFloat = (collectionView.layoutMargins.left + collectionView.layoutMargins.right)
        // layoutMargins는 컬렉션 뷰 외부 여백을 나타내며,
        // 이는 셀이 중앙으로 정렬될 때 좌우로 적용됩니다.
        // sideInset은 셀을 컬렉션 뷰의 중앙에 정렬하도록 좌우 여백을 설정합니다.
        // layoutMargins를 빼는 이유는 마진을 고려하여 중앙 정렬을 정확히 유지하기 위함입니다.
        // |<--- layoutMargins.left --->|<- sideInset ->|--- Cell ---|<- sideInset ->|<--- layoutMargins.right -->|
        let sideInset = self.view.frame.width / 2 - layoutMargins
        // `contentInset`을 변경하면 기본적으로 `contentOffset`도 영향을 받습니다.
        // 예를 들어, `left` inset을 10으로 설정하면, contentView가 x 축으로 10만큼 이동하며,
        // 이에 따라 `contentOffset.x`는 -10으로 설정됩니다.
        collectionView.contentInset.left = sideInset
        collectionView.contentInset.right = sideInset

        // margins vs. insets:
        // 마진(margins): 레이아웃의 외부 여백을 의미하며, 콘텐츠 바깥의 여유 공간을 지정합니다.
        // 인셋(insets) : 스크롤 가능한 콘텐츠의 내부 여백을 의미하며, 콘텐츠 자체의 내부 간격을 지정합니다. (스크롤 뷰의 개념)

        view.backgroundColor = .systemBackground
    }
}

extension ViewController: UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let centerPoint = CGPoint(x: self.collectionView.frame.size.width / 2 + scrollView.contentOffset.x,
                                  y: self.collectionView.frame.size.height / 2 + scrollView.contentOffset.y)

        // 지정된 중앙점(centerPoint)에 위치한 컬렉션 뷰의 indexPath를 계산합니다.
        if let indexPath = self.collectionView.indexPathForItem(at: centerPoint) {
            // 해당 indexPath에 위치한 셀을 MyCollectionViewCell로 캐스팅하여 저장합니다.
            if let centerCell = (self.collectionView.cellForItem(at: indexPath) as? MyCollectionViewCell) {
                // 빠르게 스크롤할 때, 중앙점을 벗어난 일부 셀이 원래 크기로 돌아가지 않는 버그를 해결합니다.
                if let cells = self.collectionView.visibleCells as? [MyCollectionViewCell] {
                    for cell in cells where cell !== centerCell {
                        cell.transformToStandard()
                    }
                }

                if centerCell !== self.centerCell {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
                self.centerCell = centerCell
                centerCell.transformToLarge()
            }
        }



        if let cell = centerCell {
            // 지정된 중앙 셀(centerCell)이 왼쪽으로 이동하면 offsetX가 양수(> 0),
            // 오른쪽으로 이동하면 음수(< 0)가 됩니다.
            let offsetX = centerPoint.x - cell.center.x
            print(offsetX)
            // 중앙 셀이 왼쪽으로 -15px 또는 오른쪽으로 15px 이상 이동하면,
            // 셀의 변형을 기본 상태로 되돌리고, centerCell을 nil로 설정합니다.
            if offsetX < -20 || offsetX > 20 {
                cell.transformToStandard()
                self.centerCell = nil
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return colors.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MyCollectionViewCell.id,
            for: indexPath
        )
        cell.layer.cornerRadius = cell.frame.width / 2
        cell.backgroundColor = UIColor(colors[indexPath.row])

        return cell
    }
}
