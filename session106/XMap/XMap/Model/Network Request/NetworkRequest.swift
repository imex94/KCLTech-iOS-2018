//
//  NetworkRequest.swift
//  XMap
//
//  Created by Alex Telek on 21/02/2018.
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
    
    var endpointBuilder: NetworkRequestEndpointBuilder
    var typeBuilder: NetworkRequestTypeBuilder
    var headerBuilder: [NetworkRequestHeaderBuilder]
    var parameterBuilder: [NetworkRequestParameterBuilder]
    
    static func defaultHeaderBuilder() -> [NetworkRequestHeaderBuilder] {
        
        let contentTypeHeader: NetworkRequestHeaderBuilder = {
            return (NetworkRequestKeys.contentTypeKey.rawValue, NetworkRequestKeys.jsonContentType.rawValue)
        }
        
        return [contentTypeHeader]
    }
    
    static func getTypeBuilder() -> NetworkRequestTypeBuilder {
        
        return {
            return NetworkRequestType.get
        }
    }
    
    // https://api.tfl.gov.uk/StopPoint?key=value&key=value&
    
    func buildEndpoint() -> String {
        
        var finalEndpoint = "\(endpointBuilder())?"
        
        for param in parameterBuilder {
            finalEndpoint.append("\(param().key)=\(param().value)&")
        }
        finalEndpoint.removeLast()
        
        return finalEndpoint
    }
}
