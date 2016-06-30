//
//  BaseNetworkService.swift
//  Harbor
//
//  Created by Joshua Henderson on 6/26/16.
//  Copyright © 2016 Joshua Henderson. All rights reserved.
//

import UIKit
import Alamofire

internal let hb_base_environment = ""

@objc (FLBaseNetworkService) class BaseNetworkService : NSObject {
    internal class func executeURLRequestWithParameters(httpMethod: RequestMethod!,
                                                        urlString: String!,
                                                        parameters: ([String:String!])?,
                                                        completion: ((responseData: NSDictionary?, error: NSError?) -> ())?) {
        RequestManager.executeRequestWithHTTPMethod(httpMethod,
                                                    urlString: urlString,
                                                    parameters: parameters) { (request, response, data, error) in
                                                        guard error == nil else {
                                                            if completion != nil {
                                                                completion!(responseData: nil, error: error)
                                                            }
                                                            return
                                                        }
                                                        let (error, parsedData) = JSONDictionaryFromData(data! as NSData)
                                                        
                                                        if completion != nil {
                                                            completion!(responseData: parsedData, error: error)
                                                        }
        }
    }
    
    private class func JSONDictionaryFromData(data: NSData!) -> (error: NSError?, parsedData: NSDictionary?) {
        do {
            let parsedDict = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
            
            if parsedDict.objectForKey("error") != nil {
               return (parsedDict.objectForKey("error") as? NSError, parsedDict)
            }
            return (nil, parsedDict)
        }
        catch {
            return (NSError.init(domain: "", code: 0, userInfo: nil), nil)
        }
    }
}
