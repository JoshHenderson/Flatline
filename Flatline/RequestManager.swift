//
//  RequestManager.swift
//  Harbor
//
//  Created by Joshua Henderson on 6/21/16.
//  Copyright © 2016 Joshua Henderson. All rights reserved.
//

import UIKit
import Alamofire

enum RequestMethod : String {
    case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
}

typealias RequestManagerClosureType = (NSURLRequest?, NSHTTPURLResponse?, NSData?, NSError?) -> ()

@objc (FLRequestManager) public class RequestManager : NSObject {
    
    public static let sharedInstance = RequestManager()
    private init() {}
    
    private var registeredNetworkFramework: RequestFrameworkProtocol?
    
    class func executeRequestWithHTTPMethod(httpMethod: RequestMethod!,
                                            urlString: String!,
                                            parameters: ([String:String!])?,
                                            completion: RequestManagerClosureType) {
        if let httpMethodString = Alamofire.Method(rawValue: httpMethod.rawValue) {
            Alamofire.request(httpMethodString,
                urlString,
                parameters: parameters,
                encoding: .JSON,
                headers: nil)
                .validate()
                .response { (request, response, data, error) in
                    //Reachability Madness
                    completion(request, response, data, error)
            }
        }
        else {
            completion(nil, nil, nil, nil)
        }
    }
    
}
