//
//  WeatherService
//  Weather
//
//  Created by admin on 24/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//


import Foundation
import Alamofire

protocol WeatherService {
    func getWeather(resultBlock: @escaping (Response<WeatherModel>) -> ())
    func getSunInfo(resultBlock: @escaping (Response<SunInfoModel>) -> ())
}

struct WeatherNetwork: WeatherService, NetworkService {
    
    func getWeather(resultBlock: @escaping (Response<WeatherModel>) -> ()) {
        get(NetworkConfiguration.weatherUrl, parameters: nil, headers: nil) { (response: Response<WeatherModel>) in
            switch response {
            case .success(let weatherResponseResponse):
//                print("weatherResponse == \(weatherResponseResponse)")
                resultBlock(Response.success((weatherResponseResponse)))
            case .error(let error):
                resultBlock(Response.error(error))
            }
        }
    }
    
    func getSunInfo(resultBlock: @escaping (Response<SunInfoModel>) -> ()) {
        get(NetworkConfiguration.sunInfoUrl, parameters: nil, headers: nil) { (response: Response<SunInfoModel>) in
            switch response {
            case .success(let sunInfo):
//                print("sunInfo == \(sunInfo)")
                resultBlock(Response.success((sunInfo)))
            case .error(let error):
                resultBlock(Response.error(error))
            }
        }
    }
}
