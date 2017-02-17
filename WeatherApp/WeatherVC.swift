//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by Sean Perez on 2/15/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import UIKit
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        currentWeather = CurrentWeather()
        currentWeather.downloadWeatherDetails {
            self.updateMainUI()
        }
    }
    
    func downloadForecastData(completed: Constants.DownloadComplete) {
        let forecastURL = URL(string: Constants.URLs.FORECAST_URL)!
        Alamofire.request(forecastURL).responseJSON { response in
            let result = response.result
            guard let dict = result.value as? Dictionary<String, AnyObject> else {
                print("Unable to locate results")
                return
            }
            if let list = dict["list"] as? [[String:AnyObject]] {
                for obj in list {
                    let forecast = Forecast(weatherDict: obj)
                    self.forecasts.append(forecast)
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        locationLabel.text = currentWeather._cityName
        currentTempLabel.text = String(currentWeather.currentTemp)
        currentWeatherTypeLabel.text = currentWeather.weatherType
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        
    }
    
    

}

