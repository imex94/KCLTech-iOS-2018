//
//  TFLFetcher.swift
//  XMap
//
//  Created by Alex Telek on 28/02/2018.
//  Copyright © 2018 KCLTech. All rights reserved.
//

import Foundation

class TFLFetcher: NSObject {
        
    typealias TFLFetcherStationsHandler = ([Station]) -> ()
    typealias TFLFetcherArrivalHandler = ([Tube]) -> ()
    typealias TFLFetcherModelHandler = (DataModel) -> ()
    
    class func fetchStations(at location:(Double, Double), radius: Int, handler: TFLFetcherStationsHandler? = nil) {
        
        let stationEndpoint: NetworkRequestEndpointBuilder = {
            return "\(NetworkRequestKeys.server.rawValue)\(NetworkRequestKeys.stationEndpoint.rawValue)"
        }
        
        let parameters: [NetworkRequestParameterBuilder] = [
            { (Keys.lat.rawValue, "\(location.0)") },
            { (Keys.lon.rawValue, "\(location.1)") },
            { (Keys.stopType.rawValue, Keys.naptanMetro.rawValue) },
            { (Keys.mode.rawValue, "\(Keys.tube.rawValue),\(Keys.dlr.rawValue),\(Keys.overground.rawValue)") },
            { (Keys.radius.rawValue, "\(radius)") }
        ]
        
        let networkRequest = NetworkRequest(endpointBuilder: stationEndpoint, typeBuilder: NetworkRequest.getTypeBuilder(), headerBuilder: NetworkRequest.defaultHeaderBuilder(), parameterBuilder: parameters)
        let executor = NetworkRequestExecutor(with: networkRequest)
        
        executor.execute { (responseJSON) in
            guard let stations = responseJSON as? Dictionary<String,Any> else {return}
            guard let stopPoints = stations["stopPoints"] as? Array<Any> else { return }
            
            var parsedStations = [Station]()
            for station in stopPoints {
                
                if let stationData = try? JSONSerialization.data(withJSONObject: station, options: []), let nearbyStation = try? JSONDecoder().decode(Station.self, from: stationData) {
                    parsedStations.append(nearbyStation)
                }
            }
            
            parsedStations.sort(by: {$0.distance < $1.distance})
            
            DispatchQueue.main.async {
                handler?(parsedStations)
            }
        }
    }
    
    class func fetchArrivalTubes(for stations: [Station], handler: TFLFetcherModelHandler? = nil) {
        let group = DispatchGroup()
        let model = DataModel(stations: stations)
        
        for station in stations {

            group.enter()

            fetchArrivalTubes(for: station.stationNaptan , handler: { (tubes) in

                model.addTubes(tubes, for: station.stationNaptan)
                group.leave()
            })
        }

        group.notify(queue: .main) {

            handler?(model)
        }
    }
    
    class func fetchArrivalTubes(for stationId: String, handler: TFLFetcherArrivalHandler? = nil) {
        
        let arrivalEndpoint: NetworkRequestEndpointBuilder = {
            return "\(NetworkRequestKeys.server.rawValue)\(NetworkRequestKeys.stationEndpoint.rawValue)/\(stationId)\(NetworkRequestKeys.arrivalEndpoint.rawValue)"
        }
        
        let parameters: [NetworkRequestParameterBuilder] = [
            { (Keys.mode.rawValue, Keys.tube.rawValue) }
        ]
        
        let networkRequest = NetworkRequest(endpointBuilder: arrivalEndpoint, typeBuilder: NetworkRequest.getTypeBuilder(), headerBuilder: NetworkRequest.defaultHeaderBuilder(), parameterBuilder: parameters)
        let executor = NetworkRequestExecutor(with: networkRequest)
        
        executor.execute { (responseJSON) in
            guard let tubes = responseJSON as? Array<Any> else { return }
            
            var parsedTubes = [Tube]()
            for tube in tubes {
                
                if let tubeData = try? JSONSerialization.data(withJSONObject: tube, options: []), let arrivalTube = try? JSONDecoder().decode(Tube.self, from: tubeData) {
                    parsedTubes.append(arrivalTube)
                }
            }
            
            parsedTubes.sort(by: {$0.timeToStation < $1.timeToStation})
            
            DispatchQueue.main.async {
                handler?(parsedTubes)
            }
        }
    }
}
