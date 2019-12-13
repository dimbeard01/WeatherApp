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
    var daysList: [DailyConditionsList]
    let hoursList: [HourlyConditionsList]
    let currentConditionsList: [Double]
    let currentDescription: CurrentConditions
    var cityName: String
    
    init(with model: CityForecastViewModel) {
        timezone = model.forecast.timezone
        daysList = model.forecast.daily.data

        //First element is not necessary
        daysList.remove(at: 0)
        hoursList = model.forecast.hourly.data
        currentConditionsList = NetworkWeatherForecast.CurrentlyConditionsList(with: model.forecast.currently).data
        currentDescription = model.forecast.currently
        cityName = model.city
    }
}

struct CityForecastViewModel {
    
    typealias City = Storage.City
    
    let forecast: NetworkWeatherForecast
    var city: String = ""
    
    init(with model: NetworkWeatherForecast, cities: [City]) {
        forecast = model
        city = getCity(cities: cities)
    }
    
    func getCity(cities: [City]) -> String {
        var city = ""
        
        for cityModel in cities {
            if cityModel.coordinate.latitude == forecast.latitude, cityModel.coordinate.longitude == forecast.longitude {
                city = cityModel.name
                break
            }
        }
        return city
    }
}

struct Coordinate: Hashable {
    let latitude: Double
    let longitude: Double
}
