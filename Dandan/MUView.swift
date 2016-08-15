//
//  MUView.swift
//  Dandan
//
//  Created by Jekity on 12/8/16.
//  Copyright © 2016年 Jekity. All rights reserved.
//

import UIKit

class MUView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var segmented:UISegmentedControl?
    private var button:UIButton?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.button = UIButton(frame: CGRectMake(0,50,50,20))
        
        self.button?.signalName = "btn"
        
        self.button?.backgroundColor = UIColor.orangeColor()
        
        self.addSubview(self.button!)
        
        //self.button?.memberSuperView = self
        
        self.isCustomView = true
        
        let items = ["Dandan","Dandan","Dandan"]
        
        self.segmented = UISegmentedControl(items: items)
        
        self.segmented?.frame.origin = CGPointMake(0, 40)
        
        self.segmented?.selectedSegmentIndex = 0
        
        self.segmented?.signalName = "Adaman"
        
        self.addSubview(self.segmented!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func signalProcessing_btn(notify:NSNotification){
    
        print("3200423")
    }
    func signalProcessing_forever(notify:NSNotification){
        
        print("forever")
    }
    
    func signalProcessing_Adaman(notify:NSNotification){
        
        
        let object = notify.object as! NSObject
        
        let segmented = object.tapView as! UISegmentedControl
        
        print(segmented.selectedSegmentIndex)
        
        self.removeNotificationFromObserver(self)
        
        
    }
    
    deinit{
        
        self.removeNotificationFromObserver(self)
    }
}
