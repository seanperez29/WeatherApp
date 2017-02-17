//
//  Constants.swift
//  WeatherApp
//
//  Created by Sean Perez on 2/15/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import Foundation

class Constants {
    
    struct URLs {
        static let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
        static let LATITUDE = "lat=-36"
        static let LONGITUDE = "&lon=123"
        static let APP_ID = "&appid="
        static let API_KEY = "6105c93cb9de91b8c32b2c09656e8ce5"
        static let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(LONGITUDE)\(APP_ID)\(API_KEY)"
        static let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=35&lon=139&cnt=10&appid=6105c93cb9de91b8c32b2c09656e8ce5"
    }
    
    typealias DownloadComplete = () -> ()

}
