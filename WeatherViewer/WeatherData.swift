//
//  WeatherData.swift
//  WeatherViewer
//
//  Created by Thomas Dexter on 2019-04-16.
//  Copyright © 2019 Thomas Dexter. All rights reserved.
//

import Foundation

class WeatherData {
    
    let location: String
    let currentTemperature: Int
    let description: String
    
    init (
        location: String,
        currentTemperature: Int,
        description: String
        ) {
        self.location = location
        self.currentTemperature = currentTemperature
        self.description = description
    }
}
