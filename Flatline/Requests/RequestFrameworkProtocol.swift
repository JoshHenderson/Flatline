//
//  RequestFrameworkProtocol.swift
//  Flatline
//
//  Created by Joshua Henderson on 6/30/16.
//  Copyright © 2016 Joshua Henderson. All rights reserved.
//

@objc (FLRequestFrameworkProtocol) public protocol RequestFrameworkProtocol {
    public func executeRequestWithHTTPMethod(httpMethod: RequestMethod!,
                                            urlString: String!,
                                            parameters: ([String:String!])?,
                                            completion: RequestManagerClosureType)
}