//
//  ForecastData.swift
//  WeatherViewer
//
//  Created by Thomas Dexter on 2019-04-17.
//  Copyright © 2019 Thomas Dexter. All rights reserved.
//

import Foundation

class ForecastData {
    
    let location: String
    let description: String
    let highTemperature: Int
    let lowTemperature: Int
    
    init (
        location: String,
        description: String,
        highTemperature: Int,
        lowTemperature: Int
    ) {
        self.location = location
        self.description = description
        self.highTemperature = highTemperature
        self.lowTemperature = lowTemperature
    }
}
