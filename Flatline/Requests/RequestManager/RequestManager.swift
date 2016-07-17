//
//  RequestManager.swift
//  Harbor
//
//  Created by Joshua Henderson on 6/21/16.
//  Copyright © 2016 Joshua Henderson. All rights reserved.
//

import UIKit

/**
 HTTP Request Methods.
 
 - OPTIONS: Returns the HTTP methods that the server supports.
 - GET: Read.
 - HEAD: Same as GET but returns only HTTP headers and no document body.
 - POST: Create.
 - PUT: Uploads a representation of the specified URI.
 - PATCH: Update/Modify.
 - DELETE: Deletes the specified resource.
 - TRACE: Echo's back input back to the user.
 - CONNECT: Urges your proxy to establish an HTTP tunnel to the remote end-point.
 */

@objc public enum RequestMethod : Int {
    case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
}

/**
 Closure Type for use on RequestManager object
 */

public typealias ParsedDataResponseClosureType = (AnyObject?, NSError?) -> ()

/**
    Object used to simplify the Request process. 
 
    Contains all the properties needed to execute an NSURLSession request
 */
@objc (FLRequestObject) public class RequestObject : NSObject {
    
    //HTTP Method for executing the Request
    public var httpMethod: RequestMethod!
    
    //URL String the Request will attempt to reach
    public var urlString: String?
    
    //Custom NSURLSessionConfiguration Object. Allows for Custom Header configurations
    lazy public var requestSessionConfiguration: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    
    //Request HTTP Body Parameters
    public var requestBodyParameters: [String:String]?
}

/**
    Singleton Object that manages all Request Traffic, piping it through your registered NetworkFramework, and re-directing the Response through the registered DataMapper.
 
    Allows for ease of creation when beginning a Service-Based Architecture, and is meant to act as a middle-man between your Network Framework and your Service-Layer. Handling Reachability, Server Errors, and Promoting Correct Service-Based Architecture
 */
@objc (FLRequestManager) public final class RequestManager : NSObject {
    
    private override init() {}
    /**
        Shared RequestManager Instance.
    */
    public static let sharedInstance = RequestManager()
    
    private var registeredNetworkFramework: RequestFrameworkProtocol.Type?
    
    /**
         Used to register an RequestFrameworkProtocol object to the RequestManager.
     
         This must be completed before any requests can be sent out.
     
         - Parameter framework: RequestFrameworkProtocol object that will execute all Requests
     */
    public final func registerNetworkFramework(framework: RequestFrameworkProtocol.Type!) {
        registeredNetworkFramework = framework
    }
    
    lazy private var registeredResponseDataMapper: ResponseDataMapperProtocol.Type? = BaseResponseDataMapper.self
    
    /**
         Used to register a ResponseDataMapper to allow for custom response mapping.
     
         Defaults to BaseResponseDataMapper.
     
         - Parameter dataMapper: ResponseDataMapperProtocol object that will translate all received ResponseData.
     */
    public final func registerResponseDataMapper(dataMapper: ResponseDataMapperProtocol.Type!) {
        registeredResponseDataMapper = dataMapper
    }
    
    /**
         Executes responses by passing them to the RequestFrameworkProtocol object that has been registered.
     
         If no RequestFrameworkProtocol exists, will break on an assert.
     
         - Parameter requestObject: Object containing all the information needed to make the Request 
         - Parameter completion: Completion Closure to be called when the Request completes
     */

    public final func executeRequest(requestObject:RequestObject,
                                     completion: ParsedDataResponseClosureType) {
        assert(registeredNetworkFramework != nil,
               "A Network Framework Needs to be Registered to the RequestManager using -registerNetworkFramework")
        
        registeredNetworkFramework?.executeRequest!(requestObject,
                                                    completion: { [weak self] (request, response, data, error) in
                                                        self!.registeredResponseDataMapper?.parsedDictionaryFromData!(data,
                                                            completion: { (parsedData, error) in
                                                                completion(parsedData, error)
                                                        })
            })
    }
}
