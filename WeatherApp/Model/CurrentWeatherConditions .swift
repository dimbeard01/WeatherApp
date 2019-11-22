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
