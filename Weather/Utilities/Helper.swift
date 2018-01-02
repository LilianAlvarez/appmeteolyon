
//
//  TemperatureHelper.swift
//  Weather
//
//  Created by admin on 01/01/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation

public func kelvinToCelcius(kelvinTemperature: Double) -> String {
    return String(format: "%.0f", kelvinTemperature - 273.15) + "°"
}
