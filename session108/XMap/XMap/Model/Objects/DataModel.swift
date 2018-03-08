//
//  DataModel.swift
//  XMap
//
//  Created by Alex Telek on 06/03/2018.
//  Copyright © 2018 KCLTech. All rights reserved.
//

import UIKit

class DataModel: NSObject {

    private var tubeStations = [String: [Tube]]()
    private(set) var stations: [Station]
    
    init(stations: [Station]) {
        
        self.stations = stations
    }
    
    func numberOfTubes(for stationId: String) -> Int {
        
        return tubeStations[stationId]?.count ?? 0
    }
    
    func addTubes(_ tubes: [Tube], for stationId: String) {
        
        tubeStations[stationId] = tubes
    }
    
    func getTubes(for stationId: String) -> [Tube] {
        
        return tubeStations[stationId] ?? []
    }
}
