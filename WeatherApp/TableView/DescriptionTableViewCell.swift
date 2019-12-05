//
//  DescriptionTableViewCell.swift
//  WeatherApp
//
//  Created by Dima Surkov on 27.11.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

    // MARK: - WIP

import UIKit

final class DescriptionTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier: String = "currentDescriptionCellID"

    private let topSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .white
        return separator
    }()
    
    private let bottomSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .white
        return separator
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .thin)
        return label
    }()
    
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        makeLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    
    func configure(with condition: NetworkWeatherForecast.CurrentConditions?) {
        guard let condition = condition else { return }

        let temperatureAConvertToCelsius = (condition.temperature - 32) * (5 / 9)
        let temeperature =  String(format: "%.f", temperatureAConvertToCelsius)
        
        descriptionLabel.text = {
            switch condition.icon {
            case "partly-cloudy-night":
                return "Сегодня: Сейчас переменная облачность. Температура воздуха \(temeperature)º"
            case "partly-cloudy-day":
                return "Сегодня: Сейчас переменная облачность. Температура воздуха \(temeperature)º"
            case "cloudy":
                return "Сегодня: Сейчас облачно. Температура воздуха \(temeperature)º"
            case "fog":
                return "Сегодня: Сейчас туманно. Температура воздуха \(temeperature)º"
            case "wind":
                return "Сегодня: Сейчас ветренно. Температура воздуха \(temeperature)º"
            case "sleet":
                return "Сегодня: Сейчас идет снег с дождем. Температура воздуха \(temeperature)º"
            case "snow":
                return "Сегодня: Сейчас идед снег. Температура воздуха \(temeperature)º"
            case "rain":
                return "Сегодня: Сейчас идет дождь. Температура воздуха \(temeperature)º"
            case "clear-night":
                return "Сегодня: Сейчас преимущественно ясная ночь. Температура воздуха \(temeperature)º"
            case "clear-day":
                return "Сегодня: Сейчас преимущественно ясный день. Температура воздуха \(temeperature)º"
            default :
                return ""
            }
        }()
    }
    
    // MARK: - Layout

    private func makeLayout() {
        
        [topSeparator, descriptionLabel, bottomSeparator].forEach { contentView.addSubview($0) }

        topSeparator.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalTo(bottomSeparator.snp.top).offset(-10)
            $0.trailing.equalToSuperview().offset(-40)
        }
        
        bottomSeparator.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
}
