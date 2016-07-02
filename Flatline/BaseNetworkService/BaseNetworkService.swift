//
//  BaseNetworkService.swift
//  Harbor
//
//  Created by Joshua Henderson on 6/26/16.
//  Copyright © 2016 Joshua Henderson. All rights reserved.
//

import UIKit

/**
    Root Class for the Service-Layer.
 
    Should be subclassed to take full advantage of the Architecture.
 */
@objc (FLBaseNetworkService) public class BaseNetworkService : NSObject {
    
    /**
        Function that sends a Request to the RequestManager via the RequestObject. Will also parse Errors returned from the Request and return them to you through the passed in Closure
     
        - Parameter requestObject: Object containing all the required information for the Request
        - Parameter completion: Closure that will return ParsedData or an NSError from the RequestManager
     */
    public final class func executeRequest(requestObject: RequestObject,
                                           completion: ((responseData: NSDictionary?, error: NSError?) -> ())?) {
        RequestManager.sharedInstance.executeRequest(requestObject) { (parsedData, error) in
            guard error == nil else {
                if completion != nil {
                    completion!(responseData: nil, error: error)
                }
                return
            }
            if completion != nil {
                completion!(responseData: parsedData as? NSDictionary, error: error)
            }
        }
    }
}
