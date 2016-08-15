//
//  UIView+catchCurrentController.swift
//  Dandan
//
//  Created by Jekity on 8/8/16.
//  Copyright © 2016年 Jekity. All rights reserved.
//

import Foundation

import UIKit

private var PROPERTY_KEY = UnsafeMutablePointer<CUnsignedChar>.alloc(1)

private var TOUCHES_KEY = UnsafeMutablePointer<CUnsignedChar>.alloc(1)

private var TAPVIEW_KEY = UnsafeMutablePointer<CUnsignedChar>.alloc(1)

private var GESTURE_KEY = UnsafeMutablePointer<CUnsignedChar>.alloc(1)

private var POINT_KEY = UnsafeMutablePointer<CUnsignedChar>.alloc(1)

private var COLLECTION_KEY = UnsafeMutablePointer<CUnsignedChar>.alloc(1)

private var CUSTOM_KEY = UnsafeMutablePointer<CUnsignedChar>.alloc(1)

private var observerHashTable:NSHashTable = NSHashTable.weakObjectsHashTable()

private var SELNameSet:NSMutableSet = NSMutableSet()

private var signalModal:NSObject = NSObject()

private var currentPoint:CGPoint = CGPoint()

private var pointX:CGFloat = 0

private var pointY:CGFloat = 0

extension NSObject{
    
    /** stored events which by tap*/
    
    var touches: Set<UITouch> {
        
        //add a parameter not allowed
        //let tochesKey = "tochesKey"
        
        set{
            
            objc_setAssociatedObject(self, &TOUCHES_KEY, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }get{
            
            return objc_getAssociatedObject(self, &TOUCHES_KEY) as! Set<UITouch>
        }
    }
    
    /** stored a view which by clicked*/
    
    var tapView:UIView {
        
        set{
            
            objc_setAssociatedObject(self, &TAPVIEW_KEY, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }get{
            
            return objc_getAssociatedObject(self, &TAPVIEW_KEY) as! UIView
        }

    }
    
    /** stored gesture which type of 'UITouch'*/
    var gesture:UITapGestureRecognizer {
        
        set{
            
            objc_setAssociatedObject(self, &GESTURE_KEY, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }get{
            
            return objc_getAssociatedObject(self, &GESTURE_KEY) as! UITapGestureRecognizer
        }
    }
    
    var tapPoint:CGPoint {
        
        get{
            
            return CGPoint(x: pointX, y: pointY)
        }
    }

}

/** add some parameters to UIView*/
extension UIView {
    
    //setting name of signal
        var signalName:String? {
        
           set{
            
               objc_setAssociatedObject(self, &PROPERTY_KEY,newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
            
               guard self.isKindOfClass(UIControl) else {
                
                  return
               }
            
            if self.isKindOfClass(UISwitch){
                
                let swich = self as! UISwitch
                
                swich.addTarget(self, action: "handlerControlEvents:", forControlEvents: UIControlEvents.ValueChanged)
                
            }else if self.isKindOfClass(UISegmentedControl){
                
                let segmented = self as! UISegmentedControl
                
                segmented.addTarget(self, action: "handlerControlEvents:", forControlEvents: UIControlEvents.ValueChanged)
                
            }else if self.isKindOfClass(UISlider) {
                
                let slider = self as! UISlider
                
                slider.addTarget(self, action: "handlerControlEvents:", forControlEvents: UIControlEvents.ValueChanged)
            }else if self.isKindOfClass(UIButton){
                
                let button = self as! UIButton
                
                button.addTarget(self, action: "handlerControlEvents:", forControlEvents: UIControlEvents.TouchUpInside)
                
            }else if self.isKindOfClass(UIStepper){
                
                let stepper = self as! UIStepper
                
                stepper.addTarget(self, action: "handlerControlEvents:", forControlEvents: UIControlEvents.ValueChanged)
                
            }
            
        }get{
            
                return objc_getAssociatedObject(self,&PROPERTY_KEY) as? String
            
            }
    }
    
    //return signal name of SEL(@selector(sel_singalName))
   private var SEL_signalName:String {
        
        get{
            
           return "signalProcessing_" + (self.signalName! as String) + ":"
        }
    }
    
   private var notificationSingalName:NSString {
        
        get{
            
            // let temp_name = self.getControllerOfView()
            
             let controller_name = NSStringFromClass((self.MUViewControllerFromView()?.superclass)!)
            
            return "notifycationSignal_" + controller_name + "_" + (self.signalName! as String)
        }
    }

    
   private var hashTable:NSHashTable?{
        
        get{
            
            return observerHashTable
        }
    }

    var isCustomView:Bool? {
    
    set{
    
    objc_setAssociatedObject(self, &CUSTOM_KEY,newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
    
    }get{
    
    return objc_getAssociatedObject(self,&CUSTOM_KEY) as? Bool
    
    }
    }
    
    var isCollectionViewCell:Bool? {
        
        set{
            
            objc_setAssociatedObject(self, &COLLECTION_KEY,newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            
        }get{
            
            return objc_getAssociatedObject(self,&COLLECTION_KEY) as? Bool
            
        }
    }
   
}

/**Expand child view of UITableViewCell or UICollectionView*/
extension UIView{
  
    //return a cell or nil
   private func MUTableViewFromView()->UITableViewCell?{
        
        var responderNext:UIResponder? = self.nextResponder()
    
        var isStart:Bool = true
    
       guard ((responderNext?.isFirstResponder()) != nil) else {
        
        return nil
       }
    
    repeat{
        
        if ((responderNext?.isKindOfClass(UITableViewCell)) != nil) {
            
            isStart = false
            
        }
        else{
            
            if responderNext?.nextResponder() != nil {
                
                responderNext = responderNext?.nextResponder()
                
            }else{
                
                isStart = false
                
            }
            
        }
        
        
    }while(isStart)
    
        return responderNext?.nextResponder() as? UITableViewCell
    }
    
    //return a cell or nil
    private func MUCollectionViewFromView()->UICollectionViewCell?{
        
        var responderNext:UIResponder? = self.nextResponder()
        
        var isStart:Bool = true
        
        guard ((responderNext?.isFirstResponder()) != nil) else {
            
            return nil
        }
        
        repeat{
            
            if ((responderNext?.isKindOfClass(UICollectionViewCell)) != nil) {
                
                isStart = false
            }
            else{
                
                if responderNext?.nextResponder() != nil {
                    
                    responderNext = responderNext?.nextResponder()
                    
                }else{
                    
                    isStart = false
                    
                }
                
            }
            
            
        }while(isStart)

         return responderNext?.nextResponder() as? UICollectionViewCell
    }

    //return a custom view which throws your subView
    private func MUCustomViewFromSubView() -> UIView?{
        
        var responderNext:UIResponder? = self.nextResponder()
        
        var isStart:Bool = true
        
        var customView:UIView?
        
        guard self != self.MUViewControllerFromView()?.view else {
            
            return nil
        }
        
        guard ((responderNext?.isFirstResponder()) != nil) else {
            
            return nil
        }
        
        repeat{
            
            if ((responderNext?.isKindOfClass(UIView)) != nil) {
                
                let temp = responderNext as! UIView
                
                if temp.isCustomView == true{
                    
                    customView = temp
                    
                }
                isStart = false
                
            }
            else{
                
                if responderNext?.nextResponder() != nil {
                    
                    responderNext = responderNext?.nextResponder()
                    
                }else{
                    
                    isStart = false
                    
                }
                
            }
            
        }while(isStart)

        return customView
    }

}

/**Expands child view of UIViewController*/
extension UIView{
    
    //get current controller of view
    private func MUViewControllerFromView() -> UIViewController?{
        
        var responderNext:UIResponder? = self.nextResponder()
        
        var currentViewController:UIViewController?
        
        var isStart:Bool = true
        
        guard ((responderNext?.isFirstResponder()) != nil) else{
            
            return currentViewController
        }
        
        repeat{
            
            if responderNext!.isKindOfClass(UIViewController){
                
                currentViewController = (responderNext as? UIViewController)!
                
                isStart = false
                
            }else{
                
                if ((responderNext?.nextResponder()) != nil) {
                    
                    responderNext = responderNext!.nextResponder()!
                    
                }else{
                    
                    currentViewController = nil
                    
                    isStart = false
                    
                }
                
            }
        
        }while (isStart)
        
        return currentViewController
        
    }
    
    //judged if it super class is UITableView or UICollectionView
    private  func ignoreTableView() ->Bool{
        
        let viewName = NSStringFromClass(self.classForCoder)
        
        guard (viewName.rangeOfString("TableView") != nil) else{
            
            return false
        }
        
        return true
    }
    
    func removeNotificationFromObserver(observer:UIView){
     
        NSNotificationCenter.defaultCenter().removeObserver(observer)
        
        self.hashTable?.removeAllObjects()
        
        SELNameSet.removeAllObjects()
      
    }
   
}

/**handler signal*/
extension UIView {
  
    
    /**handler controlEvents*/
    func handlerControlEvents(view:UIView){
        
       self.handlerSignalInfo()
        
    }
    
    /**handler gusture by tap*/
    func handerGestureByTap(tap:UITapGestureRecognizer){
        
        /** if not set this value which event will not executive in this method*/
        self.handlerSignalInfo()
        
        let tempPoint = tap.locationInView(tap.view?.window?.rootViewController!.view)
        
        pointX = tempPoint.x
        
        pointY = tempPoint.y
        
    }
    

    /**call which UIView by tap*/
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        /** if not set this value which event will not executive in this method */
        if self.ignoreTableView(){
            
//            #if DEBUG
//                
//                print(self.classForCoder)
//                
//            #endif
            
            super.touchesBegan(touches, withEvent: event)
            
        }else if self.isCollectionViewCell == true{
            
            super.touchesBegan(touches, withEvent: event)
        }
        
        self.handlerSignalInfo()
        
        signalModal.touches = touches
        
        let tempPoint = ((touches as NSSet).anyObject()?.locationInView(UIApplication.sharedApplication().keyWindow))!
        
        pointX = tempPoint.x
        
        pointY = tempPoint.y
    }
    /**add a observer when "hashTable" and "SET" are not containts object*/
    private func handlerHashTableAndSet(object:AnyObject,SELObject:AnyObject){
        
        guard !(observerHashTable.containsObject(object) && SELNameSet.containsObject(SELObject)) else{
            
            return
        }
        
        NSNotificationCenter.defaultCenter().addObserver(object, selector: NSSelectorFromString(SEL_signalName), name: self.notificationSingalName as String, object: nil)
        
        SELNameSet.addObject(SEL_signalName)
        
        signalModal.tapView = self
        
        observerHashTable.addObject(object)
        
    }
    
    /**post a notification*/
    private func handlerSignalInfo(){
        
        guard (self.signalName != nil) else{
            
            return
        }
        
        if (self.MUCustomViewFromSubView() != nil) {
            
            self.handlerHashTableAndSet(self.MUCustomViewFromSubView()!, SELObject: self.SEL_signalName)
           
        }else if (self.MUTableViewFromView() != nil) {
            
           self.handlerHashTableAndSet(self.MUTableViewFromView()!, SELObject: self.SEL_signalName)
            
        }else if(self.MUCollectionViewFromView() != nil) {
            
           self.handlerHashTableAndSet(self.MUCollectionViewFromView()!, SELObject: self.SEL_signalName)
            
        }else{
            
            if self.MUViewControllerFromView() != nil {
                
                self.handlerHashTableAndSet(self.MUViewControllerFromView()!, SELObject: self.SEL_signalName)
            }
            
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName(notificationSingalName as String, object: signalModal)
        
    }

}

extension UIViewController{
    

    func removeNotification() {
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
        observerHashTable.removeAllObjects()

        SELNameSet.removeAllObjects()
        
        #if DEBUG
            
        print("delloc")
        
        #endif
        
        
    }
}

