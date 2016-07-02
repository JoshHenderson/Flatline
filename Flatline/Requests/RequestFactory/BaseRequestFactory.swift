//
//  BaseRequestFactory.swift
//  Flatline
//
//  Created by Joshua Henderson on 6/30/16.
//  Copyright © 2016 Joshua Henderson. All rights reserved.
//

/**
    Default Request Factory. Used to create RequestObjects that contain all information necessary for NSURLSession requests
 */
@objc (FLBaseRequestFactory) public class BaseRequestFactory : NSObject {
    
    /**
        Default RequestObject creation method.
     
        - Parameter httpMethod: HTTP Method to be invoked on Request execution
        - Parameter urlString: URL String the Request will attempt to communicate against
        - Parameter parameters: Request body parameters that will be placed on the HTTP Body
        - Returns: RequestObject with the default NSURLSessionConfiguration
     */
    public class func defaultSessionHTTPRequest(httpMethod: RequestMethod!,
                                                urlString: String?,
                                                parameters: [String:String]?) -> RequestObject {
        let defaultRequest = RequestObject()
        defaultRequest.httpMethod = httpMethod
        defaultRequest.urlString = urlString
        defaultRequest.requestBodyParameters = parameters
        defaultRequest.requestSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        return defaultRequest
    }
    
    /**
        Custom RequestObject creation method. Used to allow customized NSURLSessionConfiguration objects to be attached to the Request.
     
     - Parameter httpMethod: HTTP Method to be invoked on Request execution
     - Parameter urlString: URL String the Request will attempt to communicate against
     - Parameter parameters: Request body parameters that will be placed on the HTTP Body
     - Parameter sessionConfiguration: Custom NSURLSessionConfiguration for your Request
     
     - Returns: RequestObject with the passed in NSURLSessionConfiguration 
     */
    public class func customizedSessionHTTPRequest(httpMethod: RequestMethod!,
                                                   urlString: String?,
                                                   parameters: [String:String]?,
                                                   sessionConfiguration: NSURLSessionConfiguration?) -> RequestObject {
        let request = defaultSessionHTTPRequest(httpMethod,
                                                urlString: urlString,
                                                parameters: parameters)
        
        guard sessionConfiguration != nil else {
            return request
        }
        
        request.requestSessionConfiguration = sessionConfiguration!
        return request
    }
}