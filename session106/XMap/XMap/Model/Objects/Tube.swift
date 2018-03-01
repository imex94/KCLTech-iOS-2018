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
}
