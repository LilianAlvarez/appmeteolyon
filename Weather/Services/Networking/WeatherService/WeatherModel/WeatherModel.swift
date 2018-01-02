//
//  WeekWeatherModel.swift
//  Weather
//
//  Created by admin on 29/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

struct WeatherModel: Codable {
    let list: [ListWeekModel]?
    let cnt: Int?
    let city: CityModel?
    let cod: String?
}
