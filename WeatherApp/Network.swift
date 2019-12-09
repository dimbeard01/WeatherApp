//
//  Network.swift
//  WeatherApp
//
//  Created by Dima Surkov on 20.11.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

import UIKit
import CoreLocation

final class Network {
    
    private let baseURL = "https://api.darksky.net/forecast/cb1efcb9b8a2a3c520bd3193b75ec38d"
    static let shared = Network()
    
    func fetchWeatherForecast(coordinate: CLLocationCoordinate2D, completion: @escaping (WeatherForecastViewModel?) -> Void) {
        
        let queryString = "\(baseURL)/\(coordinate.latitude),\(coordinate.longitude)"
        guard let url = URL(string: queryString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                completion(nil)
                return
            }
            
            #if DEBUG
            print(response.debugDescription)
            #endif
            
            guard let data = data else { return completion(nil) }
            if let networkWeatherForecast: NetworkWeatherForecast = try? JSONDecoder().decode(NetworkWeatherForecast.self, from: data) {
                let cityViewModel = CityForecastViewModel(with: networkWeatherForecast, cities: Storage.getCities())
                let weatherForecastViewModel = WeatherForecastViewModel(with: cityViewModel)
                completion(weatherForecastViewModel)
            } else {
                completion(nil)
            }
        }.resume()
    }
}

