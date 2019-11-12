//
//  DrawViewController.swift
//  MyProject
//
//  Created by Ben on 2019/10/16.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController{
    let linePath = UIBezierPath()
    let circlePath = UIBezierPath()
    let s1Path = UIBezierPath()
    let s2Path = UIBezierPath()
    
    let lineLayer = CAShapeLayer()
    let circleLayer = CAShapeLayer()
    let s1Layer = CAShapeLayer()
    let s2Layer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawRedLine()
        drawCircle()
        drawS1()
        drawS2()
        
    }
    
    func drawRedLine(){
        self.linePath.move(to: CGPoint(x: 100, y: 100))
        self.linePath.addLine(to: CGPoint(x: 100, y: 200))
        self.lineLayer.path = linePath.cgPath
        self.lineLayer.strokeColor = UIColor.red.cgColor
        self.view.layer.addSublayer(lineLayer)
    }
    
    func drawCircle(){
        let center = CGPoint(x: 300, y: 150)
        self.circlePath.addArc(withCenter: center, radius: 50, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        self.circleLayer.path = circlePath.cgPath
        self.circleLayer.strokeColor = UIColor.red.cgColor
        self.circleLayer.fillColor = UIColor.red.cgColor
        self.view.layer.addSublayer(circleLayer)
    }
    
    func drawS1(){
        let startPoint = CGPoint(x: 100, y: 350)
        let controlPoint1 = CGPoint(x: 150, y: 250)
        let controlPoint2 = CGPoint(x: 200, y: 450)
        let finalPoint = CGPoint(x: 250, y: 350)
        
        s1Path.move(to: startPoint)
        s1Path.addCurve(to: finalPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        s1Layer.path = s1Path.cgPath
        s1Layer.strokeColor = UIColor.red.cgColor
        s1Layer.fillColor = UIColor.clear.cgColor
        s1Layer.lineWidth = 3
        
        view.layer.addSublayer(s1Layer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.repeatCount = 3
        animation.duration = 10
        
        s1Layer.add(animation, forKey: "")
    }
    
    func drawS2(){
        let circleCenter = CGPoint(x: 300, y: 350)
        let circleLayer = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: circleCenter, radius: 50, startAngle: 0 - (CGFloat.pi / 2), endAngle: (CGFloat.pi * 2) - (CGFloat.pi / 2), clockwise: true)
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeColor = UIColor.blue.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineWidth = 3
        
        let circleAnimation1 = CAKeyframeAnimation(keyPath: "strokeStart")
        circleAnimation1.values = [0.0, 0.0, 0.8, 1]
        circleAnimation1.keyTimes = [0.0, 0.1, 0.9, 1.0]
        
        let circleAnimation2 = CAKeyframeAnimation(keyPath: "strokeEnd")
        circleAnimation2.values = [0.0, 0.1, 0.9, 1]
        circleAnimation2.keyTimes = [0.0, 0.1, 0.9, 1.0]
        
        let circleAnimationGroup = CAAnimationGroup()
        circleAnimationGroup.animations = [circleAnimation1, circleAnimation2]
        circleAnimationGroup.duration = 3
        circleAnimationGroup.repeatCount = Float.infinity
        let timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        circleAnimationGroup.timingFunction = timingFunction
        
        circleLayer.add(circleAnimationGroup, forKey: "loadingAnimation")
        
        self.view.layer.addSublayer(circleLayer)
    }
}
