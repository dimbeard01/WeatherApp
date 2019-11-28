//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by Dima Surkov on 21.11.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

import UIKit

struct WeatherForecast: Decodable {
    let latitude: Double
    let longitude: Double
    let timezone: String
    let currently: CurrentConditions
    let hourly: HourlyConditions
    let daily: DailyConditions

}

extension WeatherForecast {
    
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
            self.data.append(condition.precipProbability)
            self.data.append(condition.humidity)
            self.data.append(condition.windSpeed)
            self.data.append(condition.apparentTemperature)
            self.data.append(condition.precipAccumulation ?? 0)
            self.data.append(condition.pressure)
            self.data.append(condition.visibility)
            self.data.append(condition.uvIndex)
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
