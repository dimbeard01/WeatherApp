//
//  WeatherForecastViewModel.swift
//  WeatherApp
//
//  Created by Dima Surkov on 27.11.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

import UIKit

struct WeatherForecastViewModel {
    
    typealias DailyConditionsList = NetworkWeatherForecast.DailyConditionsList
    typealias HourlyConditionsList = NetworkWeatherForecast.HourlyConditionsList
    typealias CurrentConditions = NetworkWeatherForecast.CurrentConditions
    
    let timezone: String
    let daysList: [DailyConditionsList]
    let hoursList: [HourlyConditionsList]
    let currentConditionsList: [Double]
    let currentDescription: CurrentConditions
    
    init(with model: NetworkWeatherForecast) {
        timezone = model.timezone
        daysList = model.daily.data
        hoursList = model.hourly.data
        currentConditionsList = NetworkWeatherForecast.CurrentlyConditionsList(with: model.currently).data
        currentDescription = model.currently
    }
}
