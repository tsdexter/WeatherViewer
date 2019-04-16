//
//  ApiManager.swift
//  WeatherViewer
//
//  Created by Thomas Dexter on 2019-04-16.
//  Copyright © 2019 Thomas Dexter. All rights reserved.
//

import Foundation

class ApiManager {
    
    class func getWeatherData(location: String) -> WeatherData {
        
        let data = WeatherData(location: location, currentTemperature: 30, description: "Cloudy")
        return data;
    }
    
}
