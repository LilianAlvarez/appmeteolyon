//
//  RainModel.swift
//  Weather
//
//  Created by admin on 01/01/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

struct RainModel: Codable {
    var threeHours: Double?
    
    enum CodingKeys: String, CodingKey {
        case threeHours = "3h"
    }
}


