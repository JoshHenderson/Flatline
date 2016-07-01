//
//  BaseNetworkService.swift
//  Harbor
//
//  Created by Joshua Henderson on 6/26/16.
//  Copyright © 2016 Joshua Henderson. All rights reserved.
//

import UIKit

@objc (FLBaseNetworkService) public class BaseNetworkService : NSObject {
    public final class func executeRequest(httpMethod: RequestMethod!,
                                           urlString: String!,
                                           parameters: ([String:String])?,
                                           completion: ((responseData: NSDictionary?, error: NSError?) -> ())?) {
        RequestManager.sharedInstance.executeRequestWithHTTPMethod(httpMethod,
                                                                   urlString: urlString,
                                                                   parameters: parameters) { (parsedData, error) in
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
