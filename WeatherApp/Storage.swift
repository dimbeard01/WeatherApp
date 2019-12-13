//
//  Storage.swift
//  WeatherApp
//
//  Created by Dima Surkov on 06.12.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

import UIKit

final class Storage {
    
    var cities: [City] {
        return Storage.getCities()
    }
    
    static func getCities() -> [City] {
        return [City(name: "Москва", coordinate: Coordinate(latitude: 55.755825, longitude: 37.617298)),
                City(name: "Санкт-Петербург", coordinate: Coordinate(latitude: 59.934280, longitude: 30.335098)),
                City(name: "Новосибирск", coordinate: Coordinate(latitude: 55.008354, longitude: 82.935730)),
                City(name: "Екатеринбург", coordinate: Coordinate(latitude: 56.838924, longitude: 60.605701)),
                City(name: "Нижний Новгород", coordinate: Coordinate(latitude: 56.326790, longitude: 44.005989)),
                City(name: "Казань", coordinate: Coordinate(latitude: 55.830433, longitude: 49.066082)),
                City(name: "Челябинск", coordinate: Coordinate(latitude: 55.164440, longitude: 61.436844)),
                City(name: "Омск", coordinate: Coordinate(latitude: 54.988480, longitude: 73.324234)),
                City(name: "Самара", coordinate: Coordinate(latitude: 53.241505, longitude: 50.221245)),
                City(name: "Ростов-на-Дону", coordinate: Coordinate(latitude: 47.221809, longitude: 39.720261)),
                City(name: "Уфа", coordinate: Coordinate(latitude: 54.738762, longitude: 55.972054)),
                City(name: "Красноярск", coordinate: Coordinate(latitude: 56.010052, longitude: 92.852600)),
                City(name: "Пермь", coordinate: Coordinate(latitude: 58.006750, longitude: 56.228570)),
                City(name: "Воронеж", coordinate: Coordinate(latitude: 51.659908, longitude: 39.200089)),
                City(name: "Волгоград", coordinate: Coordinate(latitude: 48.708050, longitude: 44.513302)),
                City(name: "Краснодар", coordinate: Coordinate(latitude: 45.039268, longitude: 38.987221))]
    }
}

extension Storage {
    
    struct City {
        let name: String
        let coordinate: Coordinate
    }
}
