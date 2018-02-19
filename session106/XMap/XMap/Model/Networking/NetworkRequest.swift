//
//  NetworkRequest.swift
//  XMap
//
//  Created by Alex Telek on 17/02/2018.
//  Copyright © 2018 KCLTech. All rights reserved.
//

import UIKit

enum NetworkRequestType: String {
    case get = "GET"
}

typealias NetworkRequestTypeBuilder = () -> (NetworkRequestType)
typealias NetworkRequestEndpointBuilder = () -> (String)
typealias NetworkRequestHeaderBuilder = () -> (field: String, value: String)
typealias NetworkRequestParameterBuilder = () -> (key: String, value: String)

struct NetworkRequest {
    
    var enpointBuilder: NetworkRequestEndpointBuilder
    var typeBuilder: NetworkRequestTypeBuilder
    var headerBuilder: [NetworkRequestHeaderBuilder]
    var parameterBuilder: [NetworkRequestParameterBuilder]
    
    static func defaultHeaderBuilder() -> [NetworkRequestHeaderBuilder] {
        
        let contentTypeHeader: NetworkRequestHeaderBuilder = {
            return (NetworkRequestKeys.contentTypeKey.rawValue, NetworkRequestKeys.jsonContentType.rawValue)
        }
        
        return [contentTypeHeader]
    }
    
    static func getRequestTypeBuilder() -> NetworkRequestTypeBuilder {
        
        return {
            return NetworkRequestType.get
        }
    }
    
    func buildEnpoint() -> String {
        
        var endpoint = "\(enpointBuilder())?"
        
        for parameter in parameterBuilder {
            endpoint.append("\(parameter().key)=\(parameter().value)&")
        }
        
        return endpoint
    }
}
