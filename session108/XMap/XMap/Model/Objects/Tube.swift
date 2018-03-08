//
//  Tube.swift
//  XMap
//
//  Created by Alex Telek on 28/02/2018.
//  Copyright © 2018 KCLTech. All rights reserved.
//

import Foundation

struct Tube: Codable {
    
    let lineId: String
    let platformName: String
    let timeToStation: Int
    let towards: String
    
    var readableTime: String {
        let minutes = Int(timeToStation / 60)
        return minutes == 0 ? "Due" : "\(minutes) min"
    }
    
    var description: String {
        return platformName.split(separator: "-").dropLast().joined(separator: "") + " - \(towards)"
    }
}
