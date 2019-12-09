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
    
    private let bottomSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .white
        return separator
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

    func configure(with condition: WeatherForecastViewModel.CurrentConditions , name: String ) {
        temperatureLabel.text = {
            let convertToCelsius: Double = (condition.temperature - 32) * (5 / 9)
            return String(format: "%.fº", convertToCelsius)
        }()
        
        cityLabel.text = name
    }
    
    // MARK: - Layout

   private func makeLayout() {
    [cityLabel, temperatureLabel, bottomSeparator].forEach { addSubview($0) }
    
        cityLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(35)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(cityLabel.snp.bottom).offset(5)
        }
    
        bottomSeparator.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
}
