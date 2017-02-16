//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Sean Perez on 2/15/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class CurrentWeather {
    
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: @escaping Constants.DownloadComplete) {
        let currnetWeatherURL = URL(string: Constants.URLs.CURRENT_WEATHER_URL)!
        Alamofire.request(currnetWeatherURL).responseJSON { response in
            let result = response.result
            guard let dict = result.value as? Dictionary<String, AnyObject> else {
                print("Error retrieving data")
                return
            }
            if let name = dict["name"] as? String {
                self._cityName = name.capitalized
            }
            guard let weather = dict["weather"] as? [[String:AnyObject]] else {
                print("Unable find key 'weather'")
                return
            }
            if let weatherType = weather[0]["main"] as? String {
                self._weatherType = weatherType.capitalized
            }
            guard let main = dict["main"] as? [String:AnyObject] else {
                print("Unable to find key 'main'")
                return
            }
            if let currentTemp = main["temp"] as? Double {
                let kelvinToFarenheitPreDivision = (currentTemp * (9/5) - 459.67)
                let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
                self._currentTemp = kelvinToFarenheit
            }
            completed()
        }
    }
    
    
    
    
    
}
