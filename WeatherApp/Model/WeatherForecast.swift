//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by Dima Surkov on 21.11.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

import UIKit

struct WeatherForecast: Decodable {
    var latitude: Double
    var longitude: Double
    var timezone: String
    var currently: CurrentWeatherConditions
    var hourly: HourlyWeatherConditions
    var daily: DailyWeatherConditions

    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case timezone
        case currently
        case hourly
        case daily

    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.timezone = try container.decode(String.self, forKey: .timezone)
        self.currently = try container.decode(CurrentWeatherConditions.self, forKey: .currently)
        self.hourly = try container.decode(HourlyWeatherConditions.self, forKey: .hourly)
        self.daily = try container.decode(DailyWeatherConditions.self, forKey: .daily)
    }
}
