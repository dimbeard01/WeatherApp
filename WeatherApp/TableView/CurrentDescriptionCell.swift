//
//  CurrentDescriptionCell.swift
//  WeatherApp
//
//  Created by Dima Surkov on 27.11.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

    // MARK: - WIP

import UIKit

final class CurrentDescriptionCell: UITableViewCell {
    
    // MARK: - Properties

    private var topSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .white
        return separator
    }()
    
    private var bottomSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .white
        return separator
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.addSubview(topSeparator)
        contentView.addSubview(bottomSeparator)
        contentView.addSubview(descriptionLabel)
        makeLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public

    func configure(with condition: WeatherForecast.CurrentConditions) {
        
        let temperatureAConvertToCelsius = ((condition.temperature - 32)*(5/9))
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

    private func makeLayout(){
        let baseInset: CGFloat = (contentView.frame.width*5/100)
        
        topSeparator.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(1)
            $0.leading.equalTo(contentView.snp.leading)
            $0.trailing.equalTo(contentView.snp.trailing)
            $0.height.equalTo(0.7)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(10)
            $0.leading.equalTo(contentView.snp.leading).offset(baseInset)
            $0.bottom.equalTo(bottomSeparator.snp.top).offset(-10)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-baseInset*2)
        }
        
        bottomSeparator.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom)
            $0.leading.equalTo(contentView.snp.leading)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-1)
            $0.trailing.equalTo(contentView.snp.trailing)
            $0.height.equalTo(0.7)
        }
    }
}
