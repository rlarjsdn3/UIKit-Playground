//
//  ImageDetailDismissalAnimator.swift
//  PlaceBook
//
//  Created by 김건우 on 1/14/25.
//

import UIKit

final class ImageDetailPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration: TimeInterval = 0.5
    
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: .from) as? ImageGalleryViewController,
            let toViewController = transitionContext.viewController(forKey: .to) as? ImageDetailViewController,
            let fromImageView = fromViewController.selectedCell?.imageView,
            let fromImageSnapshotView = fromImageView.snapshotView(afterScreenUpdates: false)
        else {
            transitionContext.completeTransition(false)
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)
        containerView.addSubview(fromImageSnapshotView)
        toViewController.view.layoutIfNeeded()
        
        let fromViewImageFrame = fromImageView.convert(fromImageView.frame, to: containerView)
        fromImageSnapshotView.frame = fromViewImageFrame

        let toImageView = toViewController.imageView
        let toViewImageFrame = toViewController.imageView.frame
        toImageView.alpha = 0
        toImageView.frame = fromViewImageFrame

        toViewController.view.alpha = 0
        fromImageView.isHidden = true
        
        UIView.animate(
            springDuration: transitionDuration(using: transitionContext),
            bounce: 0.2,
            initialSpringVelocity: 0.5,
            delay: 0,
            options: .curveEaseInOut
        ) {
            fromImageSnapshotView.alpha = 0
            fromImageSnapshotView.frame = toViewImageFrame

            toImageView.frame = toViewImageFrame
            toImageView.alpha = 1
            toViewController.view.alpha = 1
        } completion: { _ in
            fromImageSnapshotView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
}

