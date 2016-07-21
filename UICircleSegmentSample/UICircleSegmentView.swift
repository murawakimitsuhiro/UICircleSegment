//
//  UICircleSegmentView.swift
//  VAZ_apps
//
//  Created by Murawaki on 4/26/16.
//  Copyright © 2016 Mitsuhiro_Murawaki. All rights reserved.
//

import Foundation
import UIKit

class UICircleSegmentView: UIControl{
    
    //描画色
    internal var lineColor:UIColor!{didSet{setNeedsDisplay()}};
    //大きい方の文字
    internal var value:[String]!{
        didSet{
            setValues();
        }
    }
    //小さい方の文字
    internal var sValue:[String]!{
        didSet{
            setValues();
        }
    }
    
    var selectedIndex:Int!;
    private var Circles:[CircleBtn] = [];
    private var sCircles:[UIButton] = [];
    private weak var target : AnyObject?
    private var selector : Selector?

    //View全体の大きさ, 呼び出し元クラス, 円の数, 円の大きさ, 小さな円の大きさ
    init(frame: CGRect, CircleNum:Int, CircleSize:CGFloat, sCircleSize:CGFloat) {
        self.selectedIndex = 0;
        self.lineColor = UIColor(red:0.17, green:0.65, blue:0.88, alpha:1.00);
        self.value = [];
        self.sValue = [];
        super.init(frame: frame);
        
        for i in 0..<CircleNum{
            let circleBtn = CircleBtn(frame: CGRectMake(0, 0, CircleSize, CircleSize), lineColor: lineColor);
            Circles.append(circleBtn);
            Circles[i].tag = i;
            Circles[i].addTarget(self, action: #selector(self.selectedButton(_:)), forControlEvents: .TouchUpInside);
            self.addSubview(Circles[i]);
            
            let sCircleBtn = UIButton(frame: CGRectMake(0,0,sCircleSize, sCircleSize));
            sCircles.append(sCircleBtn);
            sCircles[i].layer.cornerRadius = sCircleBtn.frame.width/2;
            sCircles[i].layer.masksToBounds = true;
            sCircles[i].layer.borderColor = lineColor.CGColor;
            sCircles[i].layer.borderWidth = 1.0;
            sCircles[i].setTitleColor(lineColor, forState: .Normal);
            sCircles[i].backgroundColor = UIColor.whiteColor();
            self.addSubview(sCircles[i]);
        }
        
        Circles[0].frame = CGRectMake(0, 0, CircleSize, CircleSize);
        Circles[0].setSelect();
        sCircles[0].center = CGPoint(x: Circles[0].center.x, y:Circles[0].frame.height + Circles[0].frame.origin.y);
        
        for i in 1..<CircleNum{
            Circles[i].frame.origin.x = CGFloat(i)*((self.frame.width-CircleSize)/CGFloat(CircleNum-1));
            sCircles[i].center = CGPoint(x: Circles[i].center.x, y:Circles[i].frame.height + Circles[i].frame.origin.y);
        }
    }
    
    internal func addTarget(target: AnyObject?, action: Selector){
        self.target = target;
        self.selector = action;
    }
    
    func setValues(){
        guard value.count > 0 else{
            return;
        }
        for i in 0..<value.count{
            Circles[i].setTitle(value[i], forState: .Normal);
            Circles[i].labelLayer.string = value[i] as NSString;
        }
        
        guard sValue.count > 0 else{
            return;
        }
        for i in 0..<sValue.count{
            sCircles[i].setTitle(sValue[i], forState: .Normal);
        }
    }
    
    func selectedButton(sender:UIButton){
        if selectedIndex != sender.tag{
            Circles[selectedIndex].removeSelect();
            selectedIndex = sender.tag
            self.sendAction(self.selector!, to: self.target, forEvent: nil);
            Circles[sender.tag].setSelect();
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CircleBtn:UIButton{
    let selectLayer: CALayer = CALayer();
    let labelLayer:CATextLayer = CATextLayer();
    
    init(frame: CGRect, lineColor:UIColor) {
        super.init(frame: frame);
        self.setTitleColor(lineColor, forState: .Normal);
        self.titleLabel?.font = UIFont.systemFontOfSize(14);
        self.layer.masksToBounds = true;
        self.layer.cornerRadius = self.frame.width/2;
        self.layer.borderColor = lineColor.CGColor;
        self.layer.borderWidth = 1.5;
        
        selectLayer.frame = CGRectMake(self.bounds.width/2, self.bounds.height/2, 0, 0);
        selectLayer.masksToBounds = true;
        selectLayer.cornerRadius = selectLayer.frame.width/2;
        selectLayer.backgroundColor = lineColor.CGColor;
        self.layer.addSublayer(selectLayer);
        
        labelLayer.frame = CGRectMake(0, 0, 80, 20);
        labelLayer.masksToBounds = true;
        labelLayer.contentsScale = UIScreen.mainScreen().scale;
        labelLayer.position = selectLayer.position;
        labelLayer.foregroundColor = UIColor.whiteColor().CGColor;
        labelLayer.alignmentMode = kCAAlignmentCenter
        labelLayer.fontSize = 14;
        labelLayer.opacity = 0;
        self.layer.addSublayer(labelLayer);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    func setSelect(){
        let move = CABasicAnimation(keyPath: "position");
        move.toValue = NSValue(CGPoint: CGPoint(x: self.bounds.width/2, y: self.bounds.height/2))
        let enlarge:CABasicAnimation = CABasicAnimation(keyPath: "bounds.size")
        enlarge.toValue = NSValue(CGSize:CGSizeMake(self.bounds.width, self.bounds.height));
        let cornar:CABasicAnimation = CABasicAnimation(keyPath: "cornerRadius");
        cornar.toValue = self.bounds.width/2;
        
        let animation = CAAnimationGroup();
        animation.animations = [move, enlarge, cornar];
        animation.removedOnCompletion = false;
        animation.fillMode = kCAFillModeForwards;
        animation.duration = 0.2;
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        selectLayer.addAnimation(animation, forKey: "select");
        
        let textAnim = CABasicAnimation(keyPath: "frame.size.width");
        textAnim.fromValue = 0;
        textAnim.toValue = self.bounds.width;
        let opacityUp:CABasicAnimation = CABasicAnimation(keyPath: "opacity");
        opacityUp.toValue = 1.0;
        let textAnimGroup = CAAnimationGroup();
        textAnimGroup.animations = [textAnim, opacityUp];
        textAnimGroup.removedOnCompletion = false;
        textAnimGroup.fillMode = kCAFillModeForwards;
        textAnimGroup.duration = 0.2;
        textAnimGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn);
        labelLayer.addAnimation(textAnimGroup, forKey: "selectText");
    }
    
    func removeSelect(){
        let smaller:CABasicAnimation = CABasicAnimation(keyPath: "bounds.size")
        smaller.fromValue = NSValue(CGSize: CGSizeMake(self.bounds.width, self.bounds.height));
        smaller.toValue = NSValue(CGSize:CGSizeMake(0, 0));
        let cornar:CABasicAnimation = CABasicAnimation(keyPath: "cornerRadius");
        cornar.fromValue = self.bounds.width/2;
        cornar.toValue = 0;
        
        let animation = CAAnimationGroup();
        animation.animations = [smaller, cornar];
        animation.removedOnCompletion = false;
        animation.fillMode = kCAFillModeForwards;
        animation.duration = 0.2;
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        selectLayer.addAnimation(animation, forKey: "select");
        
        let textAnim = CABasicAnimation(keyPath: "frame.size.width");
        textAnim.fromValue = self.bounds.width;
        textAnim.toValue = 0;
        let opacityUp:CABasicAnimation = CABasicAnimation(keyPath: "opacity");
        opacityUp.toValue = 0;
        let textAnimGroup = CAAnimationGroup();
        textAnimGroup.animations = [textAnim, opacityUp];
        textAnimGroup.removedOnCompletion = false;
        textAnimGroup.fillMode = kCAFillModeForwards;
        textAnimGroup.duration = 0.2;
        textAnimGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn);
        labelLayer.addAnimation(textAnimGroup, forKey: "selectText");
    }
}