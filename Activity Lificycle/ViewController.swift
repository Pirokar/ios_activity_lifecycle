//
//  ViewController.swift
//  Activity Lificycle
//
//  Created by Владимир Рыбалка on 14/09/2017.
//  Copyright © 2017 Vladimir Rybalka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var label: UILabel!
    private var smiley: UIImage!
    private var smileyView: UIImageView!
    private var animate = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bounds = view.bounds
        let labelFrame = CGRect(origin: CGPoint(x: bounds.origin.x, y: bounds.midY - 50), size: CGSize(width: bounds.size.width, height: 100))
        label = UILabel(frame: labelFrame)
        label.font = UIFont(name: "Helvetica", size: 70)
        label.text = "Сова!"
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.clear
        view.addSubview(label)
        
        let smileyFrame = CGRect(x: bounds.midX - 42, y: bounds.midY/2 - 42, width: 84, height: 84)
        smileyView = UIImageView(frame: smileyFrame)
        smileyView.contentMode = UIViewContentMode.center
        let smileyPath = Bundle.main.path(forResource: "smiley", ofType: "png")!
        smiley = UIImage(contentsOfFile: smileyPath)
        smileyView.image = smiley
        view.addSubview(smileyView)
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(ViewController.applicationWillResignActive), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        center.addObserver(self, selector: #selector(ViewController.applicationDidBecomeActive), name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
        center.addObserver(self, selector: #selector(ViewController.applicationDidEnterBackground), name: Notification.Name.UIApplicationDidEnterBackground, object: nil)
        center.addObserver(self, selector: #selector(ViewController.applicationWillEnterForeground), name: Notification.Name.UIApplicationWillEnterForeground, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func rotateLabelDown() {
        UIView.animate(withDuration: 0.5, animations: {
            self.label.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        },
        completion : { (Bool) -> Void in
            self.rotateLabelUp()
        })
    }
    
    func rotateLabelUp() {
        UIView.animate(withDuration: 0.5, animations: {
            self.label.transform = CGAffineTransform(rotationAngle: 0)
        },
        completion : { (Bool) -> Void in
            if(self.animate) {
                self.rotateLabelDown()
            }
        })
    }
    
    func applicationWillResignActive() {
        print("VC: \(#function)")
        animate = false
    }
    
    func applicationDidBecomeActive() {
        print("VC: \(#function)")
        animate = true
        rotateLabelDown()
    }
    
    func applicationDidEnterBackground() {
        print("VC: \(#function)")
        self.smiley = nil
        self.smileyView.image = nil
    }
    
    func applicationWillEnterForeground() {
        print("VC: \(#function)")
        let smileyPath = Bundle.main.path(forResource: "smiley", ofType: "png")!
        smiley = UIImage(contentsOfFile: smileyPath)
        smileyView.image = smiley
    }
}

