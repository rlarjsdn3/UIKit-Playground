//
//  ImageDetailPresentAnimator.swift
//  PlaceBook
//
//  Created by 김건우 on 1/14/25.
//

import UIKit

final class ImageDetailDismissalAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration: TimeInterval = 0.5
    
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: .from) as? ImageDetailViewController,
            let toViewController = transitionContext.viewController(forKey: .to) as? ImageGalleryViewController,
            let toImageView = toViewController.selectedCell?.imageView
        else {
            transitionContext.completeTransition(false)
            return
        }
        
        let containerView = transitionContext.containerView
        
        let fromViewImageFrame = fromViewController.imageView.frame
        let toViewImageFrame = toImageView.convert(toImageView.frame, to: containerView)
        toImageView.alpha = 0
        // (표시될 때 숨긴) 셀의 이미지 뷰를 숨김 처리 해제
        toImageView.isHidden = false
        // (표시될 때와 달리) 셀의 이미지 뷰를 직접 애니메이션
        toImageView.frame = fromViewImageFrame
        // 숨김 처리된 셀의 이미지는 스냅샷이 불가능
        
        UIView.animate(
            springDuration: transitionDuration(using: transitionContext),
            bounce: 0.2,
            initialSpringVelocity: 0.5,
            delay: 0,
            options: .curveEaseInOut
        ) {
            fromViewController.view.alpha = 0

            toImageView.alpha = 1
            toImageView.frame = toViewImageFrame
        } completion: { _ in
            fromViewController.view.alpha = 1
            if transitionContext.transitionWasCancelled {
                toViewController.view.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
