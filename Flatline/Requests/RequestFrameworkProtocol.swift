//
//  RequestFrameworkProtocol.swift
//  Flatline
//
//  Created by Joshua Henderson on 6/30/16.
//  Copyright © 2016 Joshua Henderson. All rights reserved.
//

/**
    Typealias for Closure used for the RequestManager
 */
public typealias RequestManagerClosureType = (NSURLRequest?, NSHTTPURLResponse?, NSData?, NSError?) -> ()

/**
    Protocol meant to be attached to Network Framework Adapters so any Networking Framework can be used with the RequestManager.
    
    The below method gets called during the RequestManager execution, and should contain a translation from RequestObject to your Network Framework.
 */
@objc (FLRequestFrameworkProtocol) public protocol RequestFrameworkProtocol {
    
    /**
        Executes the Request on the Registered Network Framework
     
        - Parameter requestObject: RequestObject that contains all the relevant parameters required for an NSURLSession Request
        - Parameter completion: Closure that should be executed when a Network call returns, whether successfully or un-successfully 
     */
    @objc optional static func executeRequest(requestObject: RequestObject,
                                              completion: RequestManagerClosureType)
}