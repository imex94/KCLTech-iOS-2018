//
//  NetworkRequestExecutor.swift
//  XMap
//
//  Created by Alex Telek on 17/02/2018.
//  Copyright © 2018 KCLTech. All rights reserved.
//

import UIKit

class NetworkRequestExecutor: NSObject {

    typealias NetworkRequestExecutorHandler = (Any) -> ()
    
    private let operationQueue = OperationQueue()
    private let request: NetworkRequest
    
    init(with networkRequest: NetworkRequest) {
        
        request = networkRequest
        
        super.init()
    }
    
    func execute(handler: @escaping NetworkRequestExecutorHandler) {
        guard let url = URL(string: request.buildEnpoint()) else { return }
        
        let urlSession = URLSession(configuration: .default, delegate: nil, delegateQueue: operationQueue)
        var urlRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60.0)
        urlRequest.httpMethod = request.typeBuilder().rawValue
        
        for header in request.headerBuilder {
            urlRequest.addValue(header().value, forHTTPHeaderField: header().field)
        }
        
        let urlTask = urlSession.dataTask(with: urlRequest) { (data, urlResponse, error) in
            guard let responseData = data else { return }
            
            if let responseJSON = try? JSONSerialization.jsonObject(with: responseData, options: []) {
                
                handler(responseJSON)
            }
        }
        urlTask.resume()
    }
}
