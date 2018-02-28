//
//  NearbyStationParsing.swift
//  XMap
//
//  Created by DevUse on 27/02/2018.
//  Copyright © 2018 KCLTech. All rights reserved.
//

import Foundation

struct Station: Codable {
    
    struct StopPoint: Codable {
        let commonName: String
        let distance: Double
        let lat: Double
        let lon: Double
        let stationNaptan: String
    }
    
    let stopPoints : [StopPoint]
}
