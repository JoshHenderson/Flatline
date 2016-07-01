//
//  BaseResponseDataMapper.swift
//  Flatline
//
//  Created by Joshua Henderson on 6/30/16.
//  Copyright © 2016 Joshua Henderson. All rights reserved.
//

import Foundation

@objc (FLResponseDataMapperProtocol) public protocol ResponseDataMapperProtocol {
    optional func parsedDictionaryFromData(data: NSData!, completion:(NSDictionary?, NSError?) -> ())
}

@objc (FLBaseResponseDataMapper) public final class BaseResponseDataMapper : NSObject, ResponseDataMapperProtocol {
    public final func parsedDictionaryFromData(data: NSData!, completion:(NSDictionary?, NSError?) -> ()) {
        do {
            let parsedDict = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
            
            if parsedDict.objectForKey("error") != nil {
                completion(parsedDict, NSError.init(domain: "", code: 0, userInfo: nil))
            }
            completion(parsedDict, nil)
        }
        catch {
            completion(nil, NSError.init(domain: "", code: 0, userInfo: nil))
        }
    }
}