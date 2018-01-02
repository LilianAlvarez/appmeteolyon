//
//  WeatherViewModel.swift
//  Weather
//
//  Created by admin on 24/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation

class WeatherViewModel {
    
    let weatherService: WeatherService
    var weather: WeatherModel!
    var sunInfo: SunInfoModel!
    
    init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    func getWeatherStatus( completionHandler: @escaping (_ errorMessge: String?)->()) {
        weatherService.getWeather { (response) in
            switch response {
            case .success(let weatherResponse):
                self.weather = weatherResponse
                self.getSunInfo(completionHandler: { (errorMessage) in
                    completionHandler(errorMessage?.description)
                })
            case .error(let error):
                completionHandler(error.description)
            }
        }
    }
    
    func getSunInfo( completionHandler: @escaping (_ errorMessge: String?)->()) {
        weatherService.getSunInfo { (response) in
            switch response {
            case .success(let sunInfo):
                self.sunInfo = sunInfo
                completionHandler(nil)
            case .error(let error):
                completionHandler(error.description)
            }
        }
    }
    
    func completeTemperature() -> String {
        if let temperatureValue: Double = weather.list?.first?.main?.temp {
            return kelvinToCelcius(kelvinTemperature: temperatureValue)
        } else {
            return ""
        }
    }
    
    func completeWeatherState() -> String {
        if let weatherValue: String = weather.list?.first?.weather?.first?.description {
            return weatherValue
        } else {
            return ""
        }
    }
    
    func completeSunriseValue() -> String {
        if let sunriseValue: Int = sunInfo.sys?.sunrise {
            return "Sunrise: \(Date(timeIntervalSince1970: TimeInterval(sunriseValue)).timeStampToDate())"
        } else {
            return ""
        }
    }

    func completeSunsetValue() -> String {
        if let sunsetValue: Int = sunInfo.sys?.sunset {
            return "Sunset: \(Date(timeIntervalSince1970: TimeInterval(sunsetValue)).timeStampToDate())"
        } else {
            return ""
        }
    }
    
    func completeCloudsValue() -> String {
        if let cloudsValue: Int = weather.list?.first?.clouds?.all {
            return "Clouds: \(String(cloudsValue)) %"
        } else {
            return ""
        }
    }
    
    func completeRainValue() -> String {
        if let rainValue: Double = weather.list?.first?.rain?.threeHours {
            return "Rain: \(String(rainValue)) mm"
        } else {
            return ""
        }
    }
    
    func completeHumidity() -> String {
        if let humidityValue: Double = weather.list?.first?.main?.humidity {
            return "Humidity: \(String(humidityValue)) %"
        } else {
            return ""
        }
    }
    
    func completePressure() -> String {
        if let pressureValue: Double = weather.list?.first?.main?.pressure {
            return "Pressure: \(String(pressureValue)) hPA"
        } else {
            return ""
        }
    }
    
}
