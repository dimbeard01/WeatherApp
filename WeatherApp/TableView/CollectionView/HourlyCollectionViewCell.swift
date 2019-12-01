//
//  HourlyCollectionViewCell.swift
//  WeatherApp
//
//  Created by Dima Surkov on 28.11.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

import UIKit

final class HourlyCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let hourlyCellID: String = "hourlyCellID"

    private let hourLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.textAlignment = .center
        return label
    }()
    
    private let weatherIconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .clear
        return image
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Public
    
    func configure(with condition: NetworkWeatherForecast.HourlyConditionsList?, indexPath: IndexPath) {
        guard let condition = condition else { return }
    
        hourLabel.text = {
            let date = Date(timeIntervalSince1970: condition.time)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH"
            
            if indexPath.item == 0 {
                return "Сейчас"
            } else {
                return dateFormatter.string(from: date)
            }
        }()
    
        weatherIconImage.image = UIImage(named: condition.icon)
        
        temperatureLabel.text = {
            let convertToCelsius = ((condition.temperature - 32)*(5/9))
            return String(format: "%.f", convertToCelsius)
        }()
    }
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        makeLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func makeLayout() {
        
        [hourLabel, weatherIconImage, temperatureLabel].forEach { contentView.addSubview($0) }
        
        hourLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.trailing.equalToSuperview()
        }
        
        weatherIconImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.center.equalToSuperview()
            $0.width.height.equalTo(20)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.centerX.equalTo(contentView.snp.centerX)
            $0.bottom.equalToSuperview().offset(-5)
            $0.trailing.leading.equalToSuperview().inset(5)
        }
    }
}
