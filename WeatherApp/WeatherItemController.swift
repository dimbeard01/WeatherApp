//
//  WeatherItemController.swift
//  WeatherApp
//
//  Created by Dima Surkov on 20.11.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

    //MARK: - WIP

import UIKit
//
class WeatherItemController {
    
    let baseURL = URL(string: "https://api.darksky.net/forecast/cb1efcb9b8a2a3c520bd3193b75ec38d/54.98848,73.324234")!
    
    static let shared = WeatherItemController()
    
    func fetchWeatherForecast(completion: @escaping (WeatherForecast?) -> Void){
        URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
            if let error = error {
                print(error)
                completion(nil)
                return
            }
  
            #if DEBUG
            print(response.debugDescription)
            #endif
            
            guard let data = data else { return completion(nil) }
            
            if let weatherData: WeatherForecast = try? JSONDecoder().decode(WeatherForecast.self, from: data) {
                completion(weatherData)
            }else {
                completion(nil)
            }
        }.resume()
    }
}

