//
//  DayWeatherTableViewCell.swift
//  Weather
//
//  Created by admin on 24/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class DayWeatherTableViewCell: UITableViewCell {

    @IBOutlet private weak var maxTemperatureLabel: UILabel!
    @IBOutlet private weak var minTemperatureLabel: UILabel!
    @IBOutlet private weak var dayLabel: UILabel!
    
    func fillWith(list: ListWeekModel) {
        if let date: Double = list.dt {
            dayLabel.text = Date(timeIntervalSince1970: date).dayOfWeek()
        }
        if let minTemperature: Double = list.main?.temp_min {
            minTemperatureLabel.text = kelvinToCelcius(kelvinTemperature: minTemperature)
        }
        if let maxTemperature: Double = list.main?.temp_max {
            maxTemperatureLabel.text = kelvinToCelcius(kelvinTemperature: maxTemperature)
        }
    }

}
