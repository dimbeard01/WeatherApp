//
//  HeaderView.swift
//  WeatherApp
//
//  Created by Dima Surkov on 22.11.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

import UIKit

final class HeaderView: UIView {
    
    // MARK: - Properties
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Омск"
        label.textAlignment = .center
        return label
    }()
    
     private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public

    func configure(with condition: NetworkWeatherForecast.CurrentConditions) {
        temperatureLabel.text = {
            let convertToCelsius: Double = (condition.temperature - 32) * (5 / 9)
            return String(format: "%.fº", convertToCelsius)
        }()
    }
    
    // MARK: - Layout

   private func makeLayout() {
        addSubview(cityLabel)
        addSubview(temperatureLabel)
        
        cityLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(20)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(cityLabel.snp.bottom).offset(10)
        }
    }
}
