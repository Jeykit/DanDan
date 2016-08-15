//
//  ViewController.swift
//  Dandan
//
//  Created by Jekity on 8/8/16.
//  Copyright © 2016年 Jekity. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {


    private var tableView:UITableView?
    
     let temView = MUView(frame: CGRectMake(10,100,100,100))
    
    private var collectionView:UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let gesure = UITapGestureRecognizer(target: self, action: nil)
        
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        //self.view.signalName = "love"
        
        let tempView = UIButton(frame: CGRectMake(100,100,100,100))
        
        tempView.signalName = "temp"
        
        tempView.setTitle("Dandan", forState: UIControlState.Normal)
        
        tempView.setImage(UIImage(named: "220257"), forState: UIControlState.Normal)
        
        tempView.backgroundColor = UIColor.redColor()
        
        self.view.addSubview(tempView)
        
        //let temView = MUView(frame: CGRectMake(10,100,100,100))
        
        temView.signalName = "dandan"
        
        temView.backgroundColor = UIColor.greenColor()
        
        self.view.addSubview(temView)
        
        let label = UILabel(frame: CGRectMake(0,0,50,50))
        
        label.signalName = "forever"
        
        label.userInteractionEnabled = true
        
        label.text = "hhhhh"
        
        temView.addSubview(label)
        
        //print(self.view.getCurrentPoint)
//        let url = "http://cs.elmsc.com/mobileapi/index.php?app=my_money&act=red_weiling&token=8b20e07981e132445d0a993da81062e6"
//        
//       let temp = MUNetworkRequest.sharedInstance
//        
//        temp.downloadData(url)
//        
//        temp.finisedDownloadToDictionary = {
//            
//            (dictionary) -> Void in
//            
//            print(dictionary)
//        }
        
        self.tableView = UITableView(frame: CGRectMake(200, 100, self.view.frame.width-200, 300), style: UITableViewStyle.Plain)
        
        self.tableView?.registerClass(MUTableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView?.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
        //self.tableView?.editing = true
        
        self.tableView?.dataSource = self
        
        self.tableView?.delegate = self
        
        self.view.addSubview(self.tableView!)
        
        let layout = UICollectionViewFlowLayout()
        
        layout.minimumLineSpacing = 10
        

        
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        
        layout.itemSize = CGSizeMake((self.view.frame.width - 4*10)/3, 100)
        
        self.collectionView = UICollectionView(frame: CGRectMake(0, 400, self.view.frame.width, 400), collectionViewLayout: layout)
        
        self.collectionView?.dataSource = self
        
        self.collectionView?.delegate = self
        
        self.collectionView?.registerClass(MUCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        self.view.addSubview(self.collectionView!)
        
        
        
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**  'signalProcessing_parameter','parameter' is string which is you defined 'signalName'*/
    func signalProcessing_temp(notify:NSNotification){
        
        
        #if DEBUG
            
        print("jehsfjh")
            
        //let modal = notify.object as! NSObject
            
       // print(modal.tapPoint)
            
            //temView.removeFromSuperview()
            
            let controller = MUViewController()
            
            self.presentViewController(controller, animated: true, completion: nil)
            
            //self.signal_dealloc()
            
        #endif
        
    }

    func signalProcessing_dandan(notify:NSNotification){
        
        #if DEBUG
            
        print("duygidogosiufgg92")
            
        let modal = notify.object as! NSObject
            
        print(modal.tapPoint)

        
        #endif
        
    }
    
    
    
    func signalProcessing_love(notify:NSNotification){
    
        let object = notify.object as! NSObject
        
        #if DEBUG
            
        print(object.tapPoint)
            
        print("34503040")
        
        #endif
    }
    
  
    
    func signalProcessing_btn(notify:NSNotification){
    
        print("11111")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! MUTableViewCell
        
//        cell!.textLabel?.text = "Good"
//        
//        cell!.userInteractionEnabled = true
//        
//        cell!.selectionStyle = UITableViewCellSelectionStyle.Blue
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print(indexPath)
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 100
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MUCollectionViewCell
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        print(indexPath)
    }
    
    
}


