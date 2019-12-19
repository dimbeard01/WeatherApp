//
//  CityWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Dima Surkov on 22.11.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

import UIKit
import CoreLocation

final class CityWeatherCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var model: WeatherForecastViewModel? {
        didSet {
            guard let model = model else { return }
            updateUI(with: model)
        }
    }
    
    static let identifier: String = "identifier"
    private let storage = Storage()
    private var weatherModel: WeatherForecastViewModel?
    private let headerView = HeaderView()
    private let collectionHeader = HourlyCollectionView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(DailyTableViewCell.self, forCellReuseIdentifier: DailyTableViewCell.dailyCellID)
        tableView.register(DescriptionTableViewCell.self, forCellReuseIdentifier: DescriptionTableViewCell.identifier)
        tableView.register(CurrentlyTableViewCell.self, forCellReuseIdentifier: CurrentlyTableViewCell.currentlyCellID)
        tableView.tableHeaderView = collectionHeader
        tableView.dataSource = self 
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
  
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Support

    private func updateUI(with model: WeatherForecastViewModel) {
        DispatchQueue.main.async {
            self.collectionHeader.model = model
            self.weatherModel = model
            self.headerView.configure(with: model.currentDescription, name: model.cityName)
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Layout
    
    private func makeLayout() {
        self.addSubview(headerView)
        self.addSubview(tableView)
        
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview() 
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionHeader.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 100)
    }
}
    
    // MARK: - Section type enumeration

extension CityWeatherCollectionViewCell {
    
    enum SectionType: Int, CaseIterable {
        case daily = 0
        case description
        case currently
        
        init(section: Int) {
            switch section {
            case 0:
                self = .daily
            case 1:
                self = .description
            case 2:
                self = .currently
            default:
                assertionFailure("Unresolved section index")
                self = .daily
            }
        }
    }
}

    // MARK: - Table view data source

extension CityWeatherCollectionViewCell: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = weatherModel else { return 0 }
        
        switch SectionType(section: section) {
        case .daily:
            return model.daysList.count
            
        case .description:
            return 1
            
        case .currently:
            return model.currentConditionsList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch SectionType(section: indexPath.section) {
        case .daily:
            return dailyCell(tableView, cellForRowAt: indexPath)
            
        case .description:
            return descriptionCell(tableView, cellForRowAt: indexPath)
            
        case .currently:
            return currentlyCell(tableView, cellForRowAt: indexPath)
        }
    }
    
    // MARK: - Setup cells
    
    private func dailyCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.dailyCellID, for: indexPath) as? DailyTableViewCell else { return UITableViewCell() }
        
        let cellModel = weatherModel?.daysList[indexPath.row]
        cell.configure(with: cellModel)
        return cell
    }
    
    private func descriptionCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.identifier, for: indexPath) as? DescriptionTableViewCell else { return UITableViewCell() }
        
        let cellModel = weatherModel?.currentDescription
        cell.configure(with: cellModel)
        return cell
    }
    
    private func currentlyCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentlyTableViewCell.currentlyCellID, for: indexPath) as? CurrentlyTableViewCell else { return UITableViewCell() }
        
        let cellModel = weatherModel?.currentConditionsList[indexPath.row]
        cell.configure(with: cellModel, indexPath: indexPath.row)
        return cell
    }
}

    // MARK: - Table view delegate

extension CityWeatherCollectionViewCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch SectionType(section: indexPath.section) {
        case .daily:
            return 30
        case .description:
            return UITableView.automaticDimension
        case .currently:
            return 60
        }
    }
}


