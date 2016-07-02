//
//  BaseResponseDataMapper.swift
//  Flatline
//
//  Created by Joshua Henderson on 6/30/16.
//  Copyright © 2016 Joshua Henderson. All rights reserved.
//

import Foundation

let defaultErrorDomain: String = "com.base.response.mapper.default.error"
let defaultErrorCode: Int = 601

/**
    Protocol used to define ResponseDataMappers and how they are interacted with from the RequestManager.
 */
@objc (FLResponseDataMapperProtocol) public protocol ResponseDataMapperProtocol {
    optional func parsedDictionaryFromData(data: NSData!, completion:(NSDictionary?, NSError?) -> ())
}

/**
    Default ResponseDataMapper, will be used if no other DataMapper has been registered to the RequestManager
 */
@objc (FLBaseResponseDataMapper) public final class BaseResponseDataMapper : NSObject, ResponseDataMapperProtocol {
    
    /**
        Protocol defined method. Used to parse data from a JSON Response from NSData. 
     
        Initially parses for an NSError object using the key 'error' from the base NSDictionary. This does not include HTTP Errors, as those have already been Vaidated in the RequestManager
     
        - Parameter data: Data received from the Request
        - Parameter completion: Closure to be executed on successful or un-successful Serialization of the NSData. Returns ParsedData or NSError
     */
    public final func parsedDictionaryFromData(data: NSData!, completion:(NSDictionary?, NSError?) -> ()) {
        do {
            let parsedDict = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
            
            if parsedDict.objectForKey("error") != nil {
                let error = NSError.init(domain: defaultErrorDomain,
                                         code: defaultErrorCode,
                                         userInfo: ["error" : parsedDict.objectForKey("error")!])
                completion(parsedDict, error)
            }
            completion(parsedDict, nil)
        }
        catch {
            let error = NSError.init(domain: defaultErrorDomain,
                                     code: defaultErrorCode,
                                     userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("Could not Convert Data", comment: "")])
            completion(nil, error)
        }
    }
}