//
//  CurrentlyTableViewCell.swift
//  WeatherApp
//
//  Created by Dima Surkov on 24.11.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

    //MARK: - WIP

import UIKit

final class CurrentlyTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
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
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        return label
    }()
    
    private var conditionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(conditionLabel)
        makeLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    
    func configure(with currentDay: Double, indexPath: Int ) {
      
        switch indexPath {
        case currentConditionType.precipProbability.rawValue:
            descriptionLabel.text = "вероятность осадков".uppercased()
            conditionLabel.text = String(currentDay)
            
        case currentConditionType.humidity.rawValue:
            descriptionLabel.text = "влажность".uppercased()
            conditionLabel.text = String(currentDay)
            
        case currentConditionType.windSpeed.rawValue:
            descriptionLabel.text = "ветер".uppercased()
            conditionLabel.text = String(currentDay)
            
        case currentConditionType.apparentTemperature.rawValue:
            descriptionLabel.text = "ощущается как".uppercased()
            conditionLabel.text = String(currentDay)
            
        case currentConditionType.precipAccumulation.rawValue:
            descriptionLabel.text = "осадки".uppercased()
            conditionLabel.text = String(currentDay)
            
        case currentConditionType.pressure.rawValue:
            descriptionLabel.text = "давление".uppercased()
            conditionLabel.text = String(currentDay)
            
        case currentConditionType.visibility.rawValue:
            descriptionLabel.text = "видимость".uppercased()
            conditionLabel.text = String(currentDay)
            
        case currentConditionType.uvIndex.rawValue:
            descriptionLabel.text = "уф-индекс".uppercased()
            conditionLabel.text = String(currentDay)
            
        default:
            break
        }
    }
    
    //MARK: - Layout
    
    private func makeLayout() {

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(10)
            $0.leading.equalTo(contentView.snp.leading).offset(20)
            $0.bottom.equalTo(conditionLabel.snp.top).offset(-10)
        }
            
        conditionLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom)
            $0.leading.equalTo(contentView.snp.leading).offset(20)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
    }
}
