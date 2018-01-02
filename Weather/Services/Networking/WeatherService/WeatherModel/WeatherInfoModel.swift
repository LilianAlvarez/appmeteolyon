//
//  WeatherInfoModel.swift
//  Weather
//
//  Created by admin on 24/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

struct WeatherInfoModel: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}
