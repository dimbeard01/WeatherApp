//
//  HourlyWeatherConditions.swift
//  WeatherApp
//
//  Created by Dima Surkov on 21.11.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

import UIKit

struct HourlyWeatherConditions: Decodable {
    var data: [HourlyConditionsList]
}

struct HourlyConditionsList: Decodable {
    var time: Double
    var icon: String
    var temperature: Double
}

