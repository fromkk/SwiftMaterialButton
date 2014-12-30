//
//  ViewController.swift
//  MaterialButton
//
//  Created by Kazuya Ueoka on 2014/12/29.
//  Copyright (c) 2014年 fromKK. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MaterialButtonProtocol {

    var debugButton: RippleButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var materialButton1 =  MaterialButton(type: MaterialButtonType.Cross)
        materialButton1.delegate = self
        self.navigationItem.leftBarButtonItem = materialButton1
        
        self.debugButton = RippleButton()
        self.debugButton.backgroundColor = UIColor(red: 240.0 / 255.0, green: 240.0 / 255.0, blue: 240.0 / 255.0, alpha: 1.0)
        self.view.addSubview(self.debugButton)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.debugButton.frame = CGRect(x: 30.0, y: 100.0, width: 200.0, height: 40.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func materialButtonDidTapped(sender: AnyObject?) {
        println("\((sender as MaterialButton).activated)")
    }
}

