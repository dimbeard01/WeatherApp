//
//  NetworkWeatherForecast.swift
//  WeatherApp
//
//  Created by Dima Surkov on 21.11.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

import UIKit

struct NetworkWeatherForecast: Decodable {
    let latitude: Double
    let longitude: Double
    let timezone: String
    let currently: CurrentConditions
    let hourly: HourlyConditions
    let daily: DailyConditions
}

extension NetworkWeatherForecast {
    
    struct CurrentConditions: Decodable {
        let time: Double
        let summary: String
        let icon: String
        let precipProbability: Double
        let precipAccumulation: Double?
        let temperature: Double
        let apparentTemperature: Double
        let humidity: Double
        let pressure: Double
        let windSpeed: Double
        let windBearing: Double
        let uvIndex: Double
        let visibility: Double
    }
    
    struct CurrentlyConditionsList: Decodable {
        var data = [Double]()
    
        init(with condition: CurrentConditions) {
            data.append(condition.precipProbability)
            data.append(condition.humidity)
            data.append(condition.windSpeed)
            data.append(condition.apparentTemperature)
            data.append(condition.precipAccumulation ?? 0)
            data.append(condition.pressure)
            data.append(condition.visibility)
            data.append(condition.uvIndex)
        }
    }
    
    struct HourlyConditions: Decodable {
        let data: [HourlyConditionsList]
    }
    
    struct HourlyConditionsList: Decodable {
        let time: Double
        let icon: String
        let temperature: Double
    }

    struct DailyConditions: Decodable {
        let data: [DailyConditionsList]
    }
    
    struct DailyConditionsList: Decodable {
        let time: Double
        let icon: String
        let temperatureHigh: Double
        let temperatureLow: Double
    }
}
