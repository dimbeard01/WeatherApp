//
//  DailyWeatherConditions.swift
//  WeatherApp
//
//  Created by Dima Surkov on 21.11.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

import UIKit

struct DailyWeatherConditions: Decodable {
    var data: [DailyConditionsList]
}

struct DailyConditionsList: Decodable {
    var time: Double
    var icon: String
    var temperatureHigh: Double
    var temperatureLow: Double  
}
