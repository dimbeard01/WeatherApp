//
//  CurrentlyCell.swift
//  WeatherApp
//
//  Created by Dima Surkov on 24.11.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

    // MARK: - WIP

import UIKit

final class CurrentlyCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let currentlyCellID: String = "currentlyCellID"

    enum currentConditionType: Int {
        case precipProbability = 0
        case humidity
        case windSpeed
        case apparentTemperature
        case precipAccumulation
        case pressure
        case visibility
        case uvIndex
    }
    
    private var separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .white
        return separator
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .thin)
        return label
    }()
    
    private var conditionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        [separator, descriptionLabel, conditionLabel].forEach { contentView.addSubview($0) }
        makeLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    
    func configure(with condition: Double, indexPath: Int ) {
    
        switch indexPath {
        case currentConditionType.precipProbability.rawValue:
            descriptionLabel.text = "вероятность осадков".uppercased()
            let precipProbability = String(format: "%.0f", (condition*100))
            conditionLabel.text = "\(precipProbability) %"
            
        case currentConditionType.humidity.rawValue:
            descriptionLabel.text = "влажность".uppercased()
            let humidity = String(format: "%.0f", (condition*100))
            conditionLabel.text = "\(humidity) %"
            
        case currentConditionType.windSpeed.rawValue:
            descriptionLabel.text = "ветер".uppercased()
            let windSpeed = String(format: "%.0f", (condition*0.45))
            conditionLabel.text = "\(windSpeed) м/с"

        case currentConditionType.apparentTemperature.rawValue:
            descriptionLabel.text = "ощущается как".uppercased()
            let apparentTemperature = String(format: "%.0f", ((condition - 32)*(5/9)))
            conditionLabel.text = "\(apparentTemperature)º"
            
        case currentConditionType.precipAccumulation.rawValue:
            descriptionLabel.text = "осадки".uppercased()
            let precipAccumulation = String(format: "%.0f", (condition*0.39))
            conditionLabel.text = "\(precipAccumulation) см"
            
        case currentConditionType.pressure.rawValue:
            descriptionLabel.text = "давление".uppercased()
            let pressure = String(format: "%.1f", (condition*0.75))
            conditionLabel.text = "\(pressure) мм рт.ст."

        case currentConditionType.visibility.rawValue:
            descriptionLabel.text = "видимость".uppercased()
            let visibility = String(format: "%.1f", (condition*1.6))
            conditionLabel.text = "\(visibility) км"

        case currentConditionType.uvIndex.rawValue:
            descriptionLabel.text = "уф-индекс".uppercased()
            let uvIndex = String(format: "%.0f", (condition))
            conditionLabel.text = "\(uvIndex)"
            separator.isHidden = true
            
        default:
            break
        }
    }
    
    // MARK: - Layout
    
    private func makeLayout() {
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(5)
            $0.leading.equalTo(contentView.snp.leading).offset(20)
            $0.bottom.equalTo(conditionLabel.snp.top).offset(-5)
        }
            
        conditionLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom)
            $0.leading.equalTo(contentView.snp.leading).offset(20)
            $0.bottom.equalTo(separator.snp.top).offset(-7)
        }
        
        separator.snp.makeConstraints {
            $0.top.equalTo(conditionLabel.snp.bottom)
            $0.leading.equalTo(contentView.snp.leading).offset(20)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-1)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-20)
            $0.height.equalTo(0.7)
        }
    }
}
