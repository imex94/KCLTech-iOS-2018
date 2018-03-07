//
//  Station.swift
//  XMap
//
//  Created by Alex Telek on 28/02/2018.
//  Copyright © 2018 KCLTech. All rights reserved.
//

import Foundation

struct Station: Codable {
    
    let commonName: String
    let distance: Double
    let lat: Double
    let lon: Double
    let stationNaptan: String
}
