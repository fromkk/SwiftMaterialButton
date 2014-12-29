//
//  RippleButton.swift
//  MaterialButton
//
//  Created by Kazuya Ueoka on 2014/12/29.
//  Copyright (c) 2014年 fromKK. All rights reserved.
//

import UIKit

protocol RippleButtonDelegate
{
    func rippleButtonTouched(sender: AnyObject?) -> Void
}

class RippleButton: UIButton
{
    private var startPosition :CGPoint!
    private var rippleView :UIView?
    var delegate :RippleButtonDelegate?
    
    override init() {
        super.init()
        
        self._initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self._initialize()
    }
    
    private func _initialize()
    {
        self.layer.masksToBounds = true
        
        if ( nil == self.rippleView )
        {
            self.rippleView = UIView()
            self.rippleView!.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
            self.rippleView!.hidden = true
            self.addSubview(self.rippleView!)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        
        let touch = touches.anyObject() as UITouch
        let point = touch.locationInView(self)
        
        self.startPosition = point
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        
        let touch = touches.anyObject() as UITouch
        let point = touch.locationInView(self)
        
        if ( false == CGPointEqualToPoint(point, self.startPosition) )
        {
            return;
        }
        
        var radius = self.frame.size.width > self.frame.size.height ? self.frame.size.width : self.frame.size.height
        
        self.rippleView!.hidden = false
        self.rippleView!.alpha = 0.5
        self.rippleView!.frame = CGRect(x: point.x - radius / 2.0 , y: point.y - radius / 2.0, width: radius, height: radius)
        self.rippleView!.layer.masksToBounds = true
        self.rippleView!.layer.cornerRadius = radius / 2
        
        let duration = 0.75
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.rippleView!.alpha = 0.0
        }, completion: {(_) -> Void in
            NSLog("completion")
            
            self.rippleView!.hidden = true
            
            self.delegate?.rippleButtonTouched(self)
        })
        var scale_animation = CABasicAnimation(keyPath: "transform.scale")
        scale_animation.duration = duration
        scale_animation.fromValue = 0.5
        scale_animation.toValue = 2.0
        self.rippleView!.layer.addAnimation(scale_animation, forKey: "transform.scale")
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
