//
//  ArrivalTubeParsing.swift
//  XMap
//
//  Created by DevUse on 27/02/2018.
//  Copyright © 2018 KCLTech. All rights reserved.
//

import Foundation

struct ArrivalTube: Codable {
    
    let lineId: String
    let platformName: String
    let timeToStation: Int
    let towards: String
}
