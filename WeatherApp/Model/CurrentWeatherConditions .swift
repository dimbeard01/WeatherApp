//
//  CurrentWeatherConditions .swift
//  WeatherApp
//
//  Created by Dima Surkov on 20.11.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

import UIKit

struct CurrentWeatherConditions: Decodable {
    var time: Double
    var summary: String
    var icon: String
    var precipProbability: Double
    var precipAccumulation: Double?
    var temperature: Double
    var apparentTemperature: Double
    var humidity: Double
    var pressure: Double
    var windSpeed: Double
    var windBearing: Double
    var uvIndex: Double
    var visibility: Double
    
}

struct CurrentConditionList {
//    var precipProbability: Double
//    var precipAccumulation: Double?
//    var temperature: Double
//    var apparentTemperature: Double
//    var humidity: Double
//    var pressure: Double
//    var windSpeed: Double
//    var windBearing: Double
//    var uvIndex: Double
//    var visibility: Double
    var arrey = [Double]()
    
    init(arrey: CurrentWeatherConditions) {
        self.arrey.append(arrey.precipProbability)
        self.arrey.append(arrey.humidity)
        self.arrey.append(arrey.windBearing)
        self.arrey.append(arrey.windSpeed)
        self.arrey.append(arrey.apparentTemperature)
        self.arrey.append(arrey.precipAccumulation ?? 0)
        self.arrey.append(arrey.pressure)
        self.arrey.append(arrey.visibility)
        self.arrey.append(arrey.uvIndex)

    }
}
