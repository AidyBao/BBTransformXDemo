//
//  ViewController.swift
//  BBTransformXDemo
//
//  Created by 120v on 2018/11/19.
//  Copyright © 2018 MQ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var closeImgVCons: NSLayoutConstraint!
    @IBOutlet weak var gap: NSLayoutConstraint!
    @IBOutlet weak var openImgV: UIImageView!
    @IBOutlet weak var closeImgV: UIImageView!
    var transFrom3D: CATransform3D = CATransform3D.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(self.closeImgV.frame.origin,self.gap.constant)
//
        self.closeImgV.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
//        print(self.closeImgV.frame.origin,self.gap.constant)
        self.closeImgVCons.constant =  -self.closeImgV.frame.size.height * 0.5
    
        self.gap.constant = -35
        self.closeImgV.layer.backgroundColor = UIColor.orange.cgColor
        self.openImgV.layer.backgroundColor = UIColor.lightGray.cgColor
        self.openImgV.isHidden = true
        self.closeImgV.isHidden = false
//        self.view.layoutIfNeeded()
        self.start()

    }
    
    
    func start() {
        transFrom3D = CATransform3DIdentity
        transFrom3D.m34 = 1.0/500
        transFrom3D = CATransform3DRotate(transFrom3D, CGFloat(Double.pi), 1, 0, 0)
        let transAnimation = CABasicAnimation(keyPath: "transform")
        transAnimation.duration = 3
        transAnimation.isRemovedOnCompletion = false
        transAnimation.fillMode = CAMediaTimingFillMode.forwards
        transAnimation.isCumulative = true
        transAnimation.autoreverses = false
        transAnimation.delegate = self
        transAnimation.toValue = NSValue(caTransform3D: transFrom3D)
        transAnimation.beginTime = CACurrentMediaTime() + 2
        transAnimation.setValue("closeImagAnimation", forKey: "closeImagAnimation")
        self.closeImgV.layer.add(transAnimation, forKey: nil)
    }
}

extension ViewController: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        UIView.animate(withDuration: 5, animations: {
            self.closeImgVCons.constant = -self.closeImgV.frame.size.height * 0.5 - 10
        }) { (finish) in
            self.gap.constant = -45
        }
    }
    
    
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        print(anim.value(forKey: "closeImagAnimation"))

        let value = anim.value(forKey: "closeImagAnimation") as? String
        if value == "closeImagAnimation" {
//            self.lipSecondOpenAnimation()
            self.closeImgV.isHidden = true
            self.openImgV.isHidden = false
        }else if value == "lipSecondOpenAnimation" {
//            self.closeImgV.isHidden = true
//            self.openImgV.isHidden = false
        }
    }
}
