//
//  ListModel.swift
//  Weather
//
//  Created by admin on 29/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

struct ListWeekModel: Codable {
    let dt: Double?
    let main: mainModel?
    let weather: [WeatherInfoModel]?
    let clouds: CloudsModel?
    let wind: WindModel?
    let dt_txt: String?
    let city: CityModel?
    let rain: RainModel?
}


