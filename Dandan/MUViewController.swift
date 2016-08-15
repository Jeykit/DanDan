//
//  MUViewController.swift
//  Dandan
//
//  Created by Jekity on 13/8/16.
//  Copyright © 2016年 Jekity. All rights reserved.
//

import UIKit

class MUViewController: UIViewController {

    var table:MUView?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.redColor()
        
        self.view.signalName = "Dandan"
        
        self.table = MUView(frame: CGRectMake(0,0,100,100))
        
        self.view.addSubview(self.table!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signalProcessing_Dandan(notify:NSNotification){
    
        //table = nil
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    deinit{
        
        self.removeNotification()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
