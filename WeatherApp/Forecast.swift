//
//  Forecast.swift
//  WeatherApp
//
//  Created by Sean Perez on 2/17/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Forecast {
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    init(weatherDict: [String:AnyObject]) {
        guard let temp = weatherDict["temp"] as? [String:AnyObject] else {
            print("Could not locate key 'temp'")
            return
        }
        if let min = temp["min"] as? Double {
            let kelvinToFarenheit = convertToKelvin(temp: min)
            self._lowTemp = String(kelvinToFarenheit)
        }
        if let max = temp["max"] as? Double {
            let kelvinToFarenheit = convertToKelvin(temp: max)
            self._highTemp = String(kelvinToFarenheit)
        }
        guard let weather = weatherDict["weather"] as? [[String:AnyObject]] else {
            print("Could not locate key 'weather'")
            return
        }
        if let main = weather[0]["main"] as? String {
            _weatherType = main
        }
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            _date = unixConvertedDate.dayOfTheWeek()
        }
    }
    
    func convertToKelvin(temp: Double) -> Double {
        let kelvinToFarenheitPreDivision = (temp * (9/5) - 459.67)
        let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPreDivision/10))
        return kelvinToFarenheit
    }
    
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
