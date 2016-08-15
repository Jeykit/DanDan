//
//  MUCollectionViewCell.swift
//  Dandan
//
//  Created by Jekity on 13/8/16.
//  Copyright © 2016年 Jekity. All rights reserved.
//

import UIKit

class MUCollectionViewCell: UICollectionViewCell {
    
    var label:UILabel?
    
    var segmented:UISegmentedControl?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.label = UILabel(frame: CGRectMake(0,0,80,40))
        
        self.label?.userInteractionEnabled = true
        
        self.label?.signalName = "Dandan"
        
        self.label?.backgroundColor = UIColor.purpleColor()
        
        self.contentView.addSubview(self.label!)
        
        self.backgroundColor = UIColor.grayColor()
        
        //print(self.subviews)
        
        self.contentView.isCollectionViewCell = true
        
        self.isCollectionViewCell = true
        
        
        
        let items = ["Dandan","Dandan","Dandan"]
        
        self.segmented = UISegmentedControl(items: items)
        
        self.segmented?.frame.origin = CGPointMake(0, 40)
        
        self.segmented?.selectedSegmentIndex = 0
        
        self.segmented?.signalName = "Adaman"
        
        //self.contentView.addSubview(self.segmented!)
        
//        let slide = UISlider(frame: CGRectMake(0,40,100,60))
//        
//        slide.maximumValue = 100
//        
//        slide.minimumValue = 0
//        
//        slide.signalName = "Adaman"
//        
//        slide.continuous = false
//        
//        self.contentView.addSubview(slide)
//        
//        let slide = UIStepper(frame: CGRectMake(0,40,100,60))
//        
//        slide.maximumValue = 100
//        
//        slide.minimumValue = 0
//        
//        slide.stepValue = 1
//        
//        slide.value = 0
//        
//        slide.wraps = true
//        
//        slide.signalName = "Adaman"
//        
//        slide.continuous = false
//        
//        self.contentView.addSubview(slide)
        
        let slide = UIProgressView(progressViewStyle: UIProgressViewStyle.Default)
        
        slide.frame.origin = CGPointMake(0, 40)
        
        slide.progress = 0.1
        
        slide.setProgress(0.5, animated: true)
        
        slide.progressTintColor = UIColor.greenColor()
        
        slide.trackTintColor = UIColor.blueColor()
        
        slide.signalName = "Adaman"
        
        self.contentView.addSubview(slide)
        
        
        
    }
    
    override func layoutSubviews() {
        
        self.label?.text = "Hello,Dandan"
    }
    
    var number:Int = 1
    func signalProcessing_Dandan(notify:NSNotification){
    
        print("UICollectionViewCell+",number)
        
        number += 1
        
        self.removeNotificationFromObserver(self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func signalProcessing_Adaman(notify:NSNotification){
    
    
        
        self.removeNotificationFromObserver(self)
        
        
    }
    
}
