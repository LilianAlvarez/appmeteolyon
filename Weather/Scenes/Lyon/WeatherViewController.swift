//
//  WeatherViewController.swift
//  Weather
//
//  Created by admin on 24/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    //TableViewRelated
    @IBOutlet private weak var tableView: UITableView!
    let pullToRefresh = UIRefreshControl()
    
    //Header
    @IBOutlet private weak var weatherStateLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    
    //Footer
    @IBOutlet private weak var sunriseTimeLabel: UILabel!
    @IBOutlet private weak var sunsetTimeLabel: UILabel!
    @IBOutlet private weak var cloudsLabel: UILabel!
    @IBOutlet private weak var rainLevelLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var pressionLabel: UILabel!
    
    //Loader
    @IBOutlet private weak var loaderActivityIndicator: UIActivityIndicatorView!
    
    var listWeekWeather = [ListWeekModel]()
    var model = WeatherViewModel(weatherService: WeatherNetwork())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.addSubview(pullToRefresh)
        pullToRefresh.addTarget(self, action: #selector(getAndUpdateWeatherData), for: UIControlEvents.valueChanged)
        self.loaderActivityIndicator.startAnimating()
        self.getAndUpdateWeatherData()
    }
    
    @objc func getAndUpdateWeatherData() {
        model.getWeatherStatus() { errorMessage in
            self.loaderActivityIndicator.stopAnimating()
            if var message: String = errorMessage {
                message = "\(String(describing: message)) Voulez-vous réessayer ?"
                let alert = UIAlertController(title: "Erreur", message: message, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Annuler", style: UIAlertActionStyle.default, handler: nil))
                alert.addAction(UIAlertAction(title: "Réessayer", style: UIAlertActionStyle.default, handler: { _ in
                    self.getAndUpdateWeatherData()
                }))
                self.present(alert, animated: true, completion: nil)
                self.pullToRefresh.endRefreshing()
            } else {
                self.completeHeader()
                self.completeFooter()
                self.sortWeekList()
                self.tableView.reloadData()
                self.pullToRefresh.endRefreshing()
            }
        }
    }
    
    func sortWeekList() {
        if let list: [ListWeekModel] = self.model.weather.list {
            listWeekWeather = [ListWeekModel]()
            if let firstList: ListWeekModel = list.first {
                self.listWeekWeather.append(firstList)
            }
            for i in 1..<list.count {
                if let dateOne: String = list[i-1].dt_txt {
                    if let dateTwo: String = list[i].dt_txt {
                        if let index = dateOne.range(of: " ")?.upperBound,
                            dateOne.prefix(upTo: index) != dateTwo.prefix(upTo: index) {
                            self.listWeekWeather.append(list[i])
                        }
                    }
                }
            }
        }
    }
    
    func completeFooter() {
        sunriseTimeLabel.text = model.completeSunriseValue()
        sunsetTimeLabel.text = model.completeSunsetValue()
        cloudsLabel.text = model.completeCloudsValue()
        rainLevelLabel.text = model.completeRainValue()
        humidityLabel.text = model.completeHumidity()
        pressionLabel.text = model.completePressure()
    }
    
    func completeHeader() {
        weatherStateLabel.text = model.completeWeatherState()
        temperatureLabel.text = model.completeTemperature()
    }
}

extension WeatherViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listWeekWeather.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DayWeatherTableViewCell = tableView.dequeueReusableCell(withIdentifier: "dayWeatherCell", for: indexPath) as! DayWeatherTableViewCell
            cell.fillWith(list: listWeekWeather[indexPath.row])
        return cell
    }
}

