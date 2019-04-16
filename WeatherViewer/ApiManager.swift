//
//  ApiManager.swift
//  WeatherViewer
//
//  Created by Thomas Dexter on 2019-04-16.
//  Copyright © 2019 Thomas Dexter. All rights reserved.
//

import Foundation
import OAuthSwift

class ApiManager {
    
    private let url: String = "https://weather-ydn-yql.media.yahoo.com/forecastrss"
    private let oauth:OAuth1Swift?
    
    private var headers:[String: String] {
        return [
            "X-Yahoo-App-Id": "MQawMP58"
        ]
    }
    
    init() {
        self.oauth = OAuth1Swift(consumerKey: "dj0yJmk9SW11cGxVZHJJa1k4JnM9Y29uc3VtZXJzZWNyZXQmc3Y9MCZ4PTBj", consumerSecret: "31f6402e94cfd083a499aa0c000e58133a81c2ab")
    }

    func getWeatherData(location: String) -> WeatherData {
        
        makeRequest(location: location, success: {(jsonData) -> Void in
            print(jsonData)
        })
        let data = WeatherData(location: location, currentTemperature: 30, description: "Cloudy")
        return data;
    }
    
    func makeRequest(location: String, success: @escaping (Any?) -> Void) {
        
        let parameters = ["location": location, "format": "json", "u": "c"]
        
        self.oauth?.client.request(
            self.url,
            method: .GET,
            parameters: parameters,
            headers: self.headers,
            body: nil,
            checkTokenExpiration: true,
            success: {(data) -> Void in
                guard let json = try? JSONSerialization.jsonObject(with: data.data) else {
                    print("Unable to convert to JSON")
                    return
                }
                success(json)
            },
            failure: {(data) -> Void in
                print(data)
            }
        )
    }
    
}
