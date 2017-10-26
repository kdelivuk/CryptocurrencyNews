//
//  FullScreenLoaderVC.swift
//  CryptocurrencyNews
//
//  Created by Kristijan Delivuk on 26/10/2017.
//  Copyright © 2017 Kristijan Delivuk. All rights reserved.
//

import UIKit
import SnapKit

class FullScreenLoaderVC: UIViewController {
    
    private var transitionDelegateProperty = FullScreenLoaderTransitioningDelegate()
    private var mainView: FullScreenLoaderView { return view as! FullScreenLoaderView }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.transitioningDelegate = transitionDelegateProperty
        self.modalPresentationStyle = .custom
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        view = FullScreenLoaderView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startAnimating()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAnimating()
    }
    
    func startAnimating() {
        mainView.loaderView.startAnimating()
    }
    
    func stopAnimating() {
        mainView.loaderView.stopAnimating()
    }
}

fileprivate class FullScreenLoaderView: UIView {
    
    fileprivate let loaderView: UIActivityIndicatorView
    
    init() {
        loaderView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        
        super.init(frame: CGRect.zero)
        
        isOpaque = false
        
        backgroundColor = Color.clear
        
        addSubview(loaderView)
        loaderView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


private class FullScreenLoaderAnimatedTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var presenting = true
    
    init(isPresenting presenting: Bool) {
        super.init()
        self.presenting = presenting
    }
    
    @objc func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    @objc func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if presenting {
            
            let presentedVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
            let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
            let containerView = transitionContext.containerView
            
            presentedView.frame = transitionContext.finalFrame(for: presentedVC)
            presentedView.alpha = 0
            
            containerView.addSubview(presentedView)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .allowUserInteraction, animations: {
                presentedView.alpha = 1
            }, completion: {(completed: Bool) -> Void in
                transitionContext.completeTransition(completed)
            })
        } else {
            
            let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
            
            // Animate the presented view off the bottom of the view
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .allowUserInteraction, animations: {
                presentedView.alpha = 0
            }, completion: {(completed: Bool) -> Void in
                transitionContext.completeTransition(completed)
            })
        }
    }
    
}

private class FullScreenLoaderPresentationController: UIPresentationController {
    
    private var dimmingView = UIView()
    
    override func presentationTransitionWillBegin() {
        
        dimmingView.frame = containerView!.bounds
        dimmingView.isOpaque = false
        dimmingView.backgroundColor = UIColor.darkGray
        dimmingView.alpha = 0
        
        containerView!.addSubview(dimmingView)
        containerView!.addSubview(presentedView!)
        
        let transitionCoordinator = presentingViewController.transitionCoordinator
        transitionCoordinator?.animate(alongsideTransition: { [weak self](context) in
            self?.dimmingView.alpha = 1.0
            }, completion: nil)
        
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            self.dimmingView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        let transitionCoordinator = presentingViewController.transitionCoordinator
        transitionCoordinator?.animate(alongsideTransition: { [weak self](context) in
            self?.dimmingView.alpha = 0.0
            }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            self.dimmingView.removeFromSuperview()
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let bounds = containerView!.bounds
        let presentedViewFrame = bounds
        return presentedViewFrame
    }
}


private class FullScreenLoaderTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    @objc func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController?, sourceViewController source: UIViewController) -> UIPresentationController? {
        let presentationController = FullScreenLoaderPresentationController(presentedViewController: presented, presenting: presenting)
        return presentationController
    }
    
    @objc func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = FullScreenLoaderAnimatedTransition(isPresenting: false)
        return animationController
    }
    
    @objc func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = FullScreenLoaderAnimatedTransition(isPresenting: true)
        return animationController
    }
    
}
