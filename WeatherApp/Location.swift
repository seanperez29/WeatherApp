//
//  Location.swift
//  WeatherApp
//
//  Created by Sean Perez on 2/17/17.
//  Copyright © 2017 SeanPerez. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
