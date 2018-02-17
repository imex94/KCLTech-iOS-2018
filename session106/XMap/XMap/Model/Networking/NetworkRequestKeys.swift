//
//  NetworkRequestKeys.swift
//  XMap
//
//  Created by Alex Telek on 17/02/2018.
//  Copyright © 2018 KCLTech. All rights reserved.
//

import Foundation

enum NetworkRequestKeys: String {
    
    case server = "https://api.tfl.gov.uk"
    case stationEndpoint = "/StopPoint"
    case arrivalEndpoint = "/Arrivals"
    
    case contentTypeKey = "Content-Type"
    case jsonContentType = "application/json"
}
