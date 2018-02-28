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
    typealias TFLFetcherStationsHandler = ([Station]) -> ()
    typealias TFLFetcherArrivalHandler = ([Tube]) -> ()
    
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
            
            var parsedStations = [Station]()
            guard let stations = responseJSON as? Dictionary<String,Any> else {return}
            guard let stopPoints = stations["stopPoints"] as? Array<Any> else {return}
            
            
            for station in stopPoints {
                
                if let stationData = try? JSONSerialization.data(withJSONObject: station, options: []), let nearbyStation = try? JSONDecoder().decode(Station.self, from: stationData) {
                    parsedStations.append(nearbyStation)
                }
            }
            
            DispatchQueue.main.async {
                handler?(parsedStations)
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
            guard let tubes = responseJSON as? Array<Any> else {return}
            
            var parsedTubes = [Tube]()
            
            for tube in tubes {
                if let tubeData = try? JSONSerialization.data(withJSONObject: tube, options: []), let arrivalTube = try? JSONDecoder().decode(Tube.self, from: tubeData) {
                    parsedTubes.append(arrivalTube)
                }
            }
            
            DispatchQueue.main.async {
                handler?(parsedTubes)
            }  
        }
    }
}
