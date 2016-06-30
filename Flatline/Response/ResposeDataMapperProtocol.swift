//
//  ResposeDataMapperProtocol.swift
//  Flatline
//
//  Created by Joshua Henderson on 6/30/16.
//  Copyright © 2016 Joshua Henderson. All rights reserved.
//

@objc (FLResponseDataMapperProtocol) public protocol ResponseDataMapperProtocol {
    optional func parsedDictionaryFromData(data: NSData!, completion:(NSDictionary?, NSError?) -> ())
}