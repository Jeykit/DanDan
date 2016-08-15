//
//  MUTableViewCell.swift
//  Dandan
//
//  Created by Jekity on 12/8/16.
//  Copyright © 2016年 Jekity. All rights reserved.
//

import UIKit

class MUTableViewCell: UITableViewCell {

    private var label:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         self.label = UILabel(frame: CGRectMake(0,0,100,40))
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        
        self.label?.backgroundColor = UIColor.blueColor()
        
        self.label?.signalName = "Dandan"
        
        self.label?.userInteractionEnabled = true
        
        self.label?.text = "Dandan"
        
        //self.label?.memberSuperView = self
        
        self.contentView.addSubview(self.label!)
        
    }
    
    func signalProcessing_Dandan(notify:NSNotification){
        
        print("dandanndnnandan")
       self.removeNotificationFromObserver(self)
    }
    
    deinit{
        
        self.removeNotificationFromObserver(self)
    }
   
}
