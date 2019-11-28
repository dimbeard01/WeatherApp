//
//  WeatherForecastViewModel.swift
//  WeatherApp
//
//  Created by Dima Surkov on 27.11.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

import UIKit

struct WeatherForecastViewModel {
    let timezone: String
    let daysList: [WeatherForecast.DailyConditionsList]
    let hoursList: [WeatherForecast.HourlyConditionsList]
    let currentConditionsList: [Double]
    let currentDescription: WeatherForecast.CurrentConditions
    
    init(with model: WeatherForecast){
        timezone = model.timezone
        daysList = model.daily.data
        hoursList = model.hourly.data
        currentConditionsList = WeatherForecast.CurrentlyConditionsList(with: model.currently).data
        currentDescription = model.currently
    }
}
