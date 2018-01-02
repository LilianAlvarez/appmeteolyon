//
//  TemperatureModel.swift
//  Weather
//
//  Created by admin on 24/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

struct mainModel: Codable {
    let temp: Double?
    let temp_min: Double?
    let temp_max: Double?
    let pressure: Double?
    let humidity: Double?
    let sea_level: Double?
    let grnd_level: Double?
    let temp_kf: Double?
}
