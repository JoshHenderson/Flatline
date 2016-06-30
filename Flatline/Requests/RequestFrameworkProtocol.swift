//
//  RequestFrameworkProtocol.swift
//  Flatline
//
//  Created by Joshua Henderson on 6/30/16.
//  Copyright © 2016 Joshua Henderson. All rights reserved.
//

import Foundation

public typealias RequestManagerClosureType = (NSURLRequest?, NSHTTPURLResponse?, NSData?, NSError?) -> ()

@objc (FLRequestFrameworkProtocol) public protocol RequestFrameworkProtocol {
    @objc optional func executeRequestWithHTTPMethod(httpMethod: RequestMethod,
                                                   urlString: String!,
                                                   parameters: ([String:String])?,
                                                   completion: RequestManagerClosureType)
}