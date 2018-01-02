//
//  SysModel.swift
//  Weather
//
//  Created by admin on 02/01/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

struct SysModel: Codable {
    let type: Int?
    let id: Int?
    let message: Double?
    let country: String?
    let sunrise: Int?
    let sunset: Int?
}
