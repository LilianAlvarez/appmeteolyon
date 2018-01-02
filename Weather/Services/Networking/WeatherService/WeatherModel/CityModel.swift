//
//  CityModel.swift
//  Weather
//
//  Created by admin on 29/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

struct CityModel: Codable {
    let id: Int?
    let name: String?
    let coord: CoordinatesModel?
    let country: String?
    let population: Int?
}
