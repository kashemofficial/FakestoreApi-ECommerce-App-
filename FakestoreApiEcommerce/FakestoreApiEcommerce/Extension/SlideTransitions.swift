//
//  SlideTransitions.swift
//  FakestoreApiEcommerce
//
//  Created by Abul Kashem on 7/1/23.
//

import UIKit

class SlideTransitions: NSObject,UIViewControllerAnimatedTransitioning{
    
    var isPresenting = false
    var dimingview = UIView()
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let fromViewController = transitionContext.viewController(forKey: .from) else{return }
        
        let containerView = transitionContext.containerView
        let finalWidth = toViewController.view.bounds.width * 1
        let finalHeight = toViewController.view.bounds.height
        if isPresenting{
            dimingview.backgroundColor = .black
            dimingview.alpha = 0.0
            containerView.addSubview(toViewController.view)
            toViewController.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHeight)
        }
        
        // animate on screen
        
        let transfrom = {
            self.dimingview.alpha = 0.5
            toViewController.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
            self.dimingview.removeFromSuperview()
        }
        
        //animate back off screen
        let identity = {
            self.dimingview.alpha = 0.5
            fromViewController.view.transform = .identity
        }
        
        let duration = transitionDuration(using: transitionContext)
        let iscanceled = transitionContext.transitionWasCancelled
        UIView.animate(withDuration: duration, animations: {self.isPresenting ? transfrom() : identity()}){
            (Bool) in
            transitionContext.completeTransition(!iscanceled)
        }
    }

}
