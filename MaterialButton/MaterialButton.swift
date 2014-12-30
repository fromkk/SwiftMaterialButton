//
//  MaterialButton.swift
//  MaterialButton
//
//  Created by Kazuya Ueoka on 2014/12/29.
//  Copyright (c) 2014年 fromKK. All rights reserved.
//

import UIKit

enum MaterialButtonType : Int
{
    case Cross      = 0
    case ArrowLeft  = 1
    case ArrowRight = 2
}

func DegreesToRadians (value:Double) -> Double {
    return value * M_PI / 180.0
}

protocol MaterialButtonProtocol
{
    func materialButtonDidTapped(sender: AnyObject?) -> Void
}

class MaterialCustomView :UIView
{
    var type: MaterialButtonType = MaterialButtonType.ArrowLeft
    var firstView  :UIView!
    var secondView :UIView!
    var thirdView  :UIView!
    var views :[UIView] = []
    var _activated :Bool = false
    var activated :Bool
    {
        set
        {
            self._activated = newValue
            
            if ( self._activated )
            {
                switch self.type
                {
                case MaterialButtonType.Cross:
                    self._cross()
                case MaterialButtonType.ArrowLeft:
                    self._arrowLeft()
                case MaterialButtonType.ArrowRight:
                    self._arrowRight()
                default:
                    self._reset(true)
                }
            } else
            {
                self._reset(true)
            }
        }
        get
        {
            return self._activated
        }
    }
    var duration = 0.25
    var delegate :MaterialButtonProtocol?
    var parentView :MaterialButton?
    
    private var startPosition :CGPoint!
    var colors :UIColor
    {
        set
        {
            for (var i = 0; i < self.views.count; i++)
            {
                var view = self.views[i]
                view.backgroundColor = newValue
            }
        }
        get
        {
            return self.firstView.backgroundColor!
        }
    }
    
    init(type: MaterialButtonType) {
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: 46.0, height: 44.0))
        
        self.type = type
        
        self.firstView  = UIView()
        self.addSubview(self.firstView)
        self.secondView = UIView()
        self.addSubview(self.secondView)
        self.thirdView  = UIView()
        self.addSubview(self.thirdView)
        
        self.views.append(self.firstView)
        self.views.append(self.secondView)
        self.views.append(self.thirdView)
        
        self.colors = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        
        self._reset(false)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        self.toggle()
        
        self.delegate?.materialButtonDidTapped(self.parentView)
    }
    
    func toggle()
    {
        self.activated = !self.activated
    }
    
    private func _reset(animated: Bool)
    {
        var closure = { () -> Void in
            var i = 0
            var margin = CGFloat(5.0)
            for (i = 0; i < self.views.count; i++)
            {
                var view = self.views[i]
                view.layer.cornerRadius = 1.5
                view.transform = CGAffineTransformIdentity
                var frame = CGRect()
                frame.origin.x = 0.0
                frame.origin.y = (CGFloat(margin) + 5.0) * CGFloat(i) + CGFloat(10.0)
                frame.size.width = 36.0
                frame.size.height = 3.0
                view.frame = frame
                view.alpha = 1.0
            }
        }
        
        if ( animated )
        {
            UIView.animateWithDuration(self.duration, animations: closure)
        } else
        {
            closure()
        }
    }
    
    private func _cross()
    {
        UIView.animateWithDuration(self.duration, animations: { () -> Void in
            self.firstView.frame = CGRect(x: 0.0, y: CGFloat((self.frame.size.height - self.firstView.frame.size.height) / 2), width: self.firstView.frame.size.width, height: self.firstView.frame.size.height)
            self.firstView.transform = CGAffineTransformMakeRotation(CGFloat(DegreesToRadians(45.0)))
            
            self.secondView.frame = CGRect(x: 0.0, y: CGFloat((self.frame.size.height - self.secondView.frame.size.height) / 2), width: self.secondView.frame.size.width, height: self.secondView.frame.size.height)
            self.secondView.transform = CGAffineTransformMakeRotation(CGFloat(DegreesToRadians(135.0)))
            
            self.thirdView.alpha = 0.0
        })
    }
    
    private func _arrowLeft()
    {
        var diff = Double(self.firstView.frame.size.width) * 0.6 * sin(DegreesToRadians(45.0)) - 8.0
        
        UIView.animateWithDuration(self.duration, animations: { () -> Void in
            var firstViewFrame = CGRect()
            firstViewFrame.origin.x = -2.5
            firstViewFrame.origin.y = CGFloat(Double(self.frame.size.height - self.firstView.frame.size.height) / 2 + diff)
            firstViewFrame.size.width = self.firstView.frame.size.width * 0.6
            firstViewFrame.size.height = self.firstView.frame.size.height
            self.firstView.frame = firstViewFrame
            self.firstView.transform = CGAffineTransformMakeRotation(CGFloat(DegreesToRadians(45.0)))
            
            self.secondView.frame = CGRect(x: 0.0, y: CGFloat((self.frame.size.height - self.secondView.frame.size.height) / 2), width: self.secondView.frame.size.width, height: self.secondView.frame.size.height)
            
            var thirdViewFrame = CGRect()
            thirdViewFrame.origin.x = -2.5
            thirdViewFrame.origin.y = CGFloat(Double(self.frame.size.height - self.thirdView.frame.size.height) / 2 - diff)
            thirdViewFrame.size.width = self.thirdView.frame.size.width * 0.6
            thirdViewFrame.size.height = self.thirdView.frame.size.height
            self.thirdView.frame = thirdViewFrame
            self.thirdView.transform = CGAffineTransformMakeRotation(CGFloat(DegreesToRadians(135.0)))
        })
    }
    
    private func _arrowRight()
    {
        var diff = Double(self.firstView.frame.size.width) * 0.6 * sin(DegreesToRadians(45.0)) - 8.0
        
        UIView.animateWithDuration(self.duration, animations: { () -> Void in
            var firstViewFrame = CGRect()
            firstViewFrame.origin.x = CGFloat(Double(self.frame.size.width) - Double(self.firstView.frame.size.width) * 0.6 - 8.0)
            firstViewFrame.origin.y = CGFloat(Double(self.frame.size.height - self.firstView.frame.size.height) / 2 + diff)
            firstViewFrame.size.width = self.firstView.frame.size.width * 0.6
            firstViewFrame.size.height = self.firstView.frame.size.height
            self.firstView.frame = firstViewFrame
            self.firstView.transform = CGAffineTransformMakeRotation(CGFloat(DegreesToRadians(135.0)))
            
            self.secondView.frame = CGRect(x: 0.0, y: CGFloat((self.frame.size.height - self.secondView.frame.size.height) / 2), width: self.secondView.frame.size.width, height: self.secondView.frame.size.height)
            
            var thirdViewFrame = CGRect()
            thirdViewFrame.origin.x = CGFloat(Double(self.frame.size.width) - Double(self.thirdView.frame.size.width) * 0.6 - 8.0)
            thirdViewFrame.origin.y = CGFloat(Double(self.frame.size.height - self.thirdView.frame.size.height) / 2 - diff)
            thirdViewFrame.size.width = self.thirdView.frame.size.width * 0.6
            thirdViewFrame.size.height = self.thirdView.frame.size.height
            self.thirdView.frame = thirdViewFrame
            self.thirdView.transform = CGAffineTransformMakeRotation(CGFloat(DegreesToRadians(45.0)))
        })
    }
}

class MaterialButton :UIBarButtonItem
{
    var type :MaterialButtonType = MaterialButtonType.ArrowLeft
    var colors :UIColor
    {
        set
        {
            (self.customView as MaterialCustomView).colors = newValue
        }
        get
        {
            return (self.customView as MaterialCustomView).colors
        }
    }
    var activated :Bool
    {
        set
        {
            (self.customView as MaterialCustomView).activated = newValue
        }
        get
        {
            return (self.customView as MaterialCustomView).activated
        }
    }
    var delegate :MaterialButtonProtocol?
    {
        set
        {
            (self.customView as MaterialCustomView).delegate = newValue
        }
        get
        {
            return (self.customView as MaterialCustomView).delegate
        }
    }
    
    func setUp()
    {
        var customView = MaterialCustomView(type: self.type)
        customView.parentView = self
        self.customView = customView
    }
    
    override init() {
        super.init()
        
        self.setUp()
    }

    init(type: MaterialButtonType)
    {
        super.init()
        self.type = type
        self.setUp()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
