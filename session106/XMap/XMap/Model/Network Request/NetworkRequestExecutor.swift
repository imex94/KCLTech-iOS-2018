//
//  NetworkRequestExecutor.swift
//  XMap
//
//  Created by Alex Telek on 21/02/2018.
//  Copyright © 2018 KCLTech. All rights reserved.
//

import UIKit

class NetworkRequestExecutor: NSObject {

    typealias NetworkRequestExecutorHandler = (Any) -> ()
    
    let networkRequest: NetworkRequest
    let operationQueue = OperationQueue()
    
    init(with networkRequest: NetworkRequest) {
        
        self.networkRequest = networkRequest
        
        super.init()
    }
    
    func execute(handler: @escaping NetworkRequestExecutorHandler) {
        guard let url = URL(string: networkRequest.buildEndpoint()) else { return }
        
        let urlSession = URLSession(configuration: .default, delegate: nil, delegateQueue: operationQueue)
        var urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad , timeoutInterval: 60.0)
        
        urlRequest.httpMethod = networkRequest.typeBuilder().rawValue
        
        for header in networkRequest.headerBuilder {
            urlRequest.addValue(header().value, forHTTPHeaderField: header().field)
        }
        
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            guard let responseData = data else { return }
            
            if let json = try? JSONSerialization.jsonObject(with: responseData, options: []) {
                
                handler(json)
            }
        }
        task.resume()
    }
}
