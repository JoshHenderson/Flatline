//
//  RequestManager.swift
//  Harbor
//
//  Created by Joshua Henderson on 6/21/16.
//  Copyright © 2016 Joshua Henderson. All rights reserved.
//

import UIKit
//import Alamofire

@objc public enum RequestMethod : Int {
    case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
}

public typealias ParsedDataResponseClosureType = (AnyObject?, NSError?) -> ()

@objc (FLRequestManager) public class RequestManager : NSObject {
    
    public static let sharedInstance = RequestManager()
    private override init() {}
    
    private var registeredNetworkFramework: RequestFrameworkProtocol?
    public func registerNetworkFramework(framework: RequestFrameworkProtocol!) {
        registeredNetworkFramework = framework
    }
    
    private var registeredResponseDataMapper: ResponseDataMapperProtocol? {
        get {
            if self.registeredResponseDataMapper == nil {
                self.registeredResponseDataMapper = BaseResponseDataMapper()
            }
            return self.registeredResponseDataMapper
        }
        set {}
    }
    public func registerResponseDataMapper(dataMapper: ResponseDataMapperProtocol!) {
        registeredResponseDataMapper = dataMapper
    }
    
    public func executeRequestWithHTTPMethod(httpMethod: RequestMethod!,
                                            urlString: String!,
                                            parameters: ([String:String])?,
                                            completion: ParsedDataResponseClosureType) {
        assert(registeredNetworkFramework != nil,
               "A Network Framework Needs to be Registered to the RequestManager using -registerNetworkFramework")
        
        registeredNetworkFramework!.executeRequestWithHTTPMethod!(httpMethod,
                                                                 urlString: urlString,
                                                                 parameters: parameters,
                                                                 completion: { [weak self] (request, response, data, error) in
                                                                    self!.registeredResponseDataMapper?.parsedDictionaryFromData!(data,
                                                                        completion: { (parsedData, error) in
                                                                            completion(parsedData, error)
                                                                    })
        })
        
//        if let httpMethodString = Alamofire.Method(rawValue: httpMethod.rawValue) {
//            Alamofire.request(httpMethodString,
//                urlString,
//                parameters: parameters,
//                encoding: .JSON,
//                headers: nil)
//                .validate()
//                .response { (request, response, data, error) in
//                    //Reachability Madness
//                    completion(request, response, data, error)
//            }
//        }
//        else {
//            completion(nil, nil, nil, nil)
//        }
    }
    
}
