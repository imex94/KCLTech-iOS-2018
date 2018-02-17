//
//  TFLFetcher.swift
//  XMap
//
//  Created by Alex Telek on 17/02/2018.
//  Copyright © 2018 KCLTech. All rights reserved.
//

import UIKit

class TFLFetcher: NSObject {

    // TODO - Parsing: These typealias responses should use the model files
    typealias TFLFetcherStationsHandler = (Any) -> ()
    typealias TFLFetcherArrivalHandler = (Any) -> ()
    
    class func fetchStations(at location: (Double, Double), handler: TFLFetcherStationsHandler? = nil) {
        
        let stationsEndpoint: NetworkRequestEndpointBuilder = {
            return "\(NetworkRequestKeys.server.rawValue)\(NetworkRequestKeys.stationEndpoint.rawValue)"
        }
        
        let parameters: [NetworkRequestParameterBuilder] = [
            { (Keys.lat.rawValue, "\(location.0)") },
            { (Keys.lon.rawValue, "\(location.1)") },
            { (Keys.stopType.rawValue, Keys.naptanMetro.rawValue) },
            { (Keys.mode.rawValue, Keys.tube.rawValue) }
        ]

        let networkRequest = NetworkRequest(enpointBuilder: stationsEndpoint, typeBuilder: NetworkRequest.getRequestTypeBuilder(), headerBuilder: NetworkRequest.defaultHeaderBuilder(), parameterBuilder: parameters)
        let executor = NetworkRequestExecutor(with: networkRequest)
        
        executor.execute { (responseJSON) in
            
            // Received Data for parsing
            // Do some work...Mahyad?
            
            DispatchQueue.main.async {
                handler?(responseJSON)
            }
        }
    }
    
    class func fetchArrivalTrains(for stationId: String, handler: TFLFetcherArrivalHandler? = nil) {
        
        let arrivalEndpoint: NetworkRequestEndpointBuilder = {
            return "\(NetworkRequestKeys.server.rawValue)\(NetworkRequestKeys.stationEndpoint.rawValue)/\(stationId)\(NetworkRequestKeys.arrivalEndpoint.rawValue)"
        }
        
        let parameter: NetworkRequestParameterBuilder = {
            return (Keys.mode.rawValue, Keys.tube.rawValue)
        }
        
        let networkRequest = NetworkRequest(enpointBuilder: arrivalEndpoint, typeBuilder: NetworkRequest.getRequestTypeBuilder(), headerBuilder: NetworkRequest.defaultHeaderBuilder(), parameterBuilder: [parameter])
        let executor = NetworkRequestExecutor(with: networkRequest)
        
        executor.execute { (responseJSON) in
            
            // Received Data for parsing
            // Do some work...Mahyad?
            
            DispatchQueue.main.async {
                handler?(responseJSON)
            }
        }
    }
}
