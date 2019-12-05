//
//  CurrentlyTableViewCell.swift
//  WeatherApp
//
//  Created by Dima Surkov on 24.11.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

import UIKit

final class CurrentlyTableViewCell: UITableViewCell {
    
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
    
    private let separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .white
        return separator
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 15, weight: .thin)
        return label
    }()
    
    private let conditionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .semibold)
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
    
    func configure(with condition: Double?, indexPath: Int) {
        guard let condition = condition else { return }

        switch indexPath {
        case currentConditionType.precipProbability.rawValue:
            descriptionLabel.text = "вероятность осадков".uppercased()
            let precipProbability = String(format: "%.0f", (condition * 100))
            conditionLabel.text = "\(precipProbability) %"
            
        case currentConditionType.humidity.rawValue:
            descriptionLabel.text = "влажность".uppercased()
            let humidity = String(format: "%.0f", (condition * 100))
            conditionLabel.text = "\(humidity) %"
            
        case currentConditionType.windSpeed.rawValue:
            descriptionLabel.text = "ветер".uppercased()
            let windSpeed = String(format: "%.0f", (condition * 0.45))
            conditionLabel.text = "\(windSpeed) м/с"

        case currentConditionType.apparentTemperature.rawValue:
            descriptionLabel.text = "ощущается как".uppercased()
            let apparentTemperature = String(format: "%.0f", ((condition - 32) * (5 / 9)))
            conditionLabel.text = "\(apparentTemperature)º"
            
        case currentConditionType.precipAccumulation.rawValue:
            descriptionLabel.text = "осадки".uppercased()
            let precipAccumulation = String(format: "%.0f", (condition * 0.39))
            conditionLabel.text = "\(precipAccumulation) см"
            
        case currentConditionType.pressure.rawValue:
            descriptionLabel.text = "давление".uppercased()
            let pressure = String(format: "%.1f", (condition * 0.75))
            conditionLabel.text = "\(pressure) мм рт.ст."

        case currentConditionType.visibility.rawValue:
            descriptionLabel.text = "видимость".uppercased()
            let visibility = String(format: "%.1f", (condition * 1.6))
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
        
        [separator, descriptionLabel, conditionLabel].forEach { contentView.addSubview($0) }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalTo(conditionLabel.snp.top).offset(-5)
        }
            
        conditionLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalTo(separator.snp.top).offset(-5)
        }
        
        separator.snp.makeConstraints {
            $0.top.equalTo(conditionLabel.snp.bottom)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(0.5)
        }
    }
}
