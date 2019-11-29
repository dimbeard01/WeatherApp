//
//  DailyCell.swift
//  WeatherApp
//
//  Created by Dima Surkov on 22.11.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

    // MARK: - WIP

import UIKit

final class DailyCell: UITableViewCell {
    
    // MARK: - Properties

    private let languageCode = "ru_RU"
    static let dailyCellID: String = "dailyCellID"

    private var dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        label.textAlignment = .left
        return label
    }()
    
    private var temperatureDayLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        label.textAlignment = .right
        return label
    }()
    
    private var temperatureNightLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        label.textAlignment = .right
        return label
    }()
    
    private var weatherIconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = UIColor.clear
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        [dayOfWeekLabel, weatherIconImage, temperatureDayLabel, temperatureNightLabel].forEach { contentView.addSubview($0) }
        makeLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    
    func configure(with condition: WeatherForecast.DailyConditionsList) {
        
        temperatureNightLabel.text = {
            let convertToCelsius = ((condition.temperatureLow - 32)*(5/9))
            return String(format: "%.f", convertToCelsius)
        }()
        
        temperatureDayLabel.text = {
            let convertToCelsius = ((condition.temperatureHigh - 32)*(5/9))
            return String(format: "%.f", convertToCelsius)
        }()
        
        dayOfWeekLabel.text = {
            let date = Date(timeIntervalSince1970: condition.time)
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: languageCode)
            dateFormatter.dateFormat = "EEEE"
            return dateFormatter.string(from: date).capitalized
        }()
        
        weatherIconImage.image = {
            let image = UIImage(named: condition.icon)
            return image
        }()
    }
    
    // MARK: - Layout

    private func makeLayout(){
        let baseInset: CGFloat = (contentView.frame.width*7/100)

        dayOfWeekLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(5)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-5)
            $0.leading.equalTo(contentView.snp.leading).offset(baseInset)
            $0.width.equalTo((38*contentView.frame.width)/100)
        }
        
        weatherIconImage.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(5)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-5)
            $0.centerX.equalTo(contentView.snp.centerX)
            $0.height.equalTo(20)
            $0.width.equalTo(25)
        }

        temperatureDayLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(5)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-5)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-contentView.frame.width/4)
        }
        
        temperatureNightLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(5)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-5)
            $0.leading.equalTo(temperatureDayLabel.snp.trailing)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-baseInset)
        }
    }
}
