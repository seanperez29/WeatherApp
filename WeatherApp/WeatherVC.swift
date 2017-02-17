//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by Sean Perez on 2/15/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var currentWeather: CurrentWeather!
    var forecast: Forecast!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        currentWeather = CurrentWeather()
        forecast = Forecast()
        currentWeather.downloadWeatherDetails {
            self.updateMainUI()
        }
    }
    
    func downloadForecastData(completed: Constants.DownloadComplete) {
        let forecastURL = URL(string: <#T##String#>)
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

