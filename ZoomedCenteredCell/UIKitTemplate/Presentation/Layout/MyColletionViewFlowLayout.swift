//
//  MyColletionViewFlowLayout.swift
//  UIKitTemplate
//
//  Created by 김건우 on 5/8/25.
//

import UIKit

final class MyColletionViewFlowLayout: UICollectionViewFlowLayout {

    // 컬렉션 뷰의 레이아웃을 초기화하거나 레이아웃이 무효화될 때마다 호출됩니다.
    // 이 메서드를 통해 레이아웃 연산을 수행하기 위한 사전 설정을 구성할 수 있습니다.
    override func prepare() {
        super.prepare()

        scrollDirection = .horizontal
        minimumInteritemSpacing = 16
        minimumLineSpacing = 16
        itemSize = CGSize(width: 32, height: 32)
    }

    // 사용자가 스크롤을 멈출 때 콘텐츠 뷰가 정지할 최종 위치를 지정할 수 있는 메서드입니다.
    override func targetContentOffset(
        forProposedContentOffset proposedContentOffset: CGPoint,
        withScrollingVelocity velocity: CGPoint
    ) -> CGPoint {

        // 최종 오프셋 위치를 조정할 값. 처음에는 무한대 값으로 설정하여 최소값 비교에 사용합니다.
        var offsetAdjustment: CGFloat = .greatestFiniteMagnitude

        // 예상된 정지 위치에 contentInset.left 값을 추가하여 실제 스크롤된 위치를 계산합니다.
        let horizontalOffset = proposedContentOffset.x + collectionView!.contentInset.left

        // 스크롤 종료 후의 예상 영역 (현재 보이는 영역) 설정
        let targetRect = CGRect(
            x: proposedContentOffset.x, // 예상 X 오프셋 위치
            y: 0,                       // Y는 수직 스크롤이 없으므로 0
            width: collectionView!.bounds.size.width,  // 현재 컬렉션 뷰의 너비
            height: collectionView!.bounds.size.height // 현재 컬렉션 뷰의 높이
        )

        // 지정된 영역 내에 있는 모든 레이아웃 속성(셀, 헤더, 푸터 등)을 가져옵니다.
        let layoutAttributesArray = super.layoutAttributesForElements(in: targetRect)

        // 가져온 모든 레이아웃 속성을 순회하여 가장 가까운 셀의 위치를 찾습니다.
        layoutAttributesArray?.forEach { layoutAttributes in
            // 각 셀의 X 좌표 (시작 위치) 확인
            let itemOffset = layoutAttributes.frame.origin.x

            // 중앙에 가장 가까운 셀을 찾기 위해 오프셋 차이를 계산합니다.
            if fabsf(Float(itemOffset - horizontalOffset)) < fabsf(Float(offsetAdjustment)) {
                // 가장 작은 오프셋 차이를 가진 셀로 오프셋을 조정합니다.
                offsetAdjustment = itemOffset - horizontalOffset
            }
        }

        // 예상된 위치에서 가장 가까운 셀 위치로 오프셋을 조정하여 최종 위치를 반환합니다.
        return CGPoint(
            x: proposedContentOffset.x + offsetAdjustment,
            y: proposedContentOffset.y
        )
    }
}
