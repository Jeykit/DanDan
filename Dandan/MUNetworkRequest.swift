//
//  MUNetworkRequest.swift
//  Dandan
//
//  Created by Jekity on 10/8/16.
//  Copyright © 2016年 Jekity. All rights reserved.
//

import UIKit

enum requestMethod:String {
    
    case post = "POST"
    
    case get  = "GET"
}


 private var dictionary:NSDictionary?

class MUNetworkRequest: NSObject{

   static let sharedInstance = MUNetworkRequest()
    
    var finisedDownloadToDictionary:((dict:NSDictionary)->(Void))?
    
    override init() {
        
        super.init()
    }
    
    class func uploadImage(uploadImage:UIImage,uploadURL:String){
    
        let data = UIImagePNGRepresentation(uploadImage)
        
        let request = NSMutableURLRequest(URL: NSURL(string: uploadURL)!)
        
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        request.addValue("image/png", forHTTPHeaderField: "Content-Type")
        
        request.addValue("text/html", forHTTPHeaderField: "Accept")
        
        request.HTTPMethod = "POST"
        
        let session = NSURLSession.sharedSession()
        
        let dataTask:NSURLSessionDataTask = session.uploadTaskWithRequest(request, fromData: data) { (data, response, error) -> Void in
            
            if error != nil{
                
                #if DEBUG
                    
                print(error?.code)
                
                print(error?.description)
                
                #endif
                
            }else{
                
                #if DEBUG
                    
                    let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    
                    print("sucess",str)
                    
                #endif
            }
        }
        
        //start task
        dataTask.resume()
        
    }
    
    func uploadText(dict:NSDictionary,uploadURL:String){
        
        let request = NSMutableURLRequest(URL: NSURL(string: uploadURL)!)
        
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var data:NSData = NSData()
        
        do {
          
             data = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted)
        }
        catch let error as NSError{
            
            #if DEBUG
                
            print(error)
            
            #endif
        }
        
        request.HTTPMethod = "POST"
        
        let session = NSURLSession.sharedSession()
        
        let dataTask:NSURLSessionDataTask = session.uploadTaskWithRequest(request, fromData: data) { (data, response, error) -> Void in
            
            if error != nil{
                
                #if DEBUG
                
                print(error?.code)
                
                print(error?.description)
                
                #endif
                
            }else{
                
                var dictionary:NSDictionary = NSDictionary()
                
                do{
                    
                   dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                    
                }catch let error as NSError {
                    
                    #if DEBUG
                        
                    print(error)
                    
                    #endif
                    
                }
                
                #if DEBUG
                    
                print("sucess",dictionary.description)
                
                #endif
            }
        }
        
        //start task
        dataTask.resume()
        
    }

    func downloadData(downloadURL:String){
        
        let request = NSMutableURLRequest(URL: NSURL(string: downloadURL)!)
        
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        request.HTTPMethod = "GET"
        
        //let config  = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let session = NSURLSession.sharedSession()
        
        //let session = NSURLSession(configuration: config, delegate: self, delegateQueue: NSOperationQueue())
        
        //let dataTask = session.dataTaskWithRequest(request)
        
        let dataTask:NSURLSessionDataTask = session.dataTaskWithRequest(request) { (mdata, responsed, error) -> Void in
           
//            if (responsed! as! NSHTTPURLResponse).statusCode != 200{
//                
//                return
//            }
            do{
                
            dictionary = try NSJSONSerialization.JSONObjectWithData(mdata!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
                
                self.finisedDownloadToDictionary!(dict: dictionary!)
                
            }catch let error as NSError {
                
                #if DEBUG
                
                print(error.description)
                
                #endif
            }
            
        }
        //start task
           
        dataTask.resume()
 
    }
    
//    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
//        
//        self.finisedDownloadToDictionary!(dict: dictionary!)
//        
//        print("325435")
//    }
}
