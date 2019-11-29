//
//  HourlyCell.swift
//  WeatherApp
//
//  Created by Dima Surkov on 28.11.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

import UIKit

class HourlyCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let hourlyCellID: String = "hourlyCellID"

    private var hourLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        label.textAlignment = .center
        return label
    }()
    
    private var weatherIconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = UIColor.clear
        return image
    }()
    
    private var temperatureLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Public
    
    func configure(with condition: WeatherForecast.HourlyConditionsList) {
        hourLabel.text = {
            let date = Date(timeIntervalSince1970: condition.time)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH"
            return dateFormatter.string(from: date)
        }()
    
        weatherIconImage.image = {
            let image = UIImage(named: condition.icon)
            return image
        }()
        
        temperatureLabel.text = {
            let convertToCelsius = ((condition.temperature - 32)*(5/9))
            return String(format: "%.f", convertToCelsius)
        }()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        
        [hourLabel, weatherIconImage, temperatureLabel].forEach { contentView.addSubview($0) }
        makeLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func makeLayout() {
        hourLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(5)
            $0.centerX.equalTo(contentView.snp.centerX)
        }
        
        weatherIconImage.snp.makeConstraints {
            $0.center.equalTo(contentView.center)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.centerX.equalTo(contentView.snp.centerX)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-5)
        }
    }
}
