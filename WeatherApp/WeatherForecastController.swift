//
//  WeatherForecastController.swift
//  WeatherApp
//
//  Created by Dima Surkov on 22.11.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

import UIKit
import SnapKit

final class WeatherForecastController: UIViewController {
    
    // MARK: - Properties
    
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
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeLayout()
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "back"))
        fetchWeatherForecast()
    }
    
    // MARK: - Support
    
    private func fetchWeatherForecast() {
        NetworkWeatherController.shared.fetchWeatherForecast { [weak self] (forecast) in
            if let forecast = forecast {
                DispatchQueue.main.async {
                    self?.updateUI(with: forecast)
                }
            }
        }
    }
    
    private func updateUI(with data: NetworkWeatherForecast) {
        DispatchQueue.main.async {
            let model = WeatherForecastViewModel(with: data)
            self.collectionHeader.model = model
            self.weatherModel = model
            self.headerView.configure(with: model.currentDescription)
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Layout
    
    private func makeLayout() {
        view.addSubview(headerView)
        view.addSubview(tableView)
        
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        collectionHeader.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 100)
    }
}

    // MARK: - Section type enumeration

extension WeatherForecastController {
    
    enum SectionType: Int, CaseIterable {
        case daily = 0
        case description
        case currently
        
        var height: CGFloat {
            switch self {
            case .daily:
                return 30
            case .description:
                return UITableView.automaticDimension
            case .currently:
                return 60
            }
        }
        
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

extension WeatherForecastController: UITableViewDataSource {
    
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

extension WeatherForecastController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case SectionType.daily.rawValue:
            return SectionType.daily.height
            
        case SectionType.description.rawValue:
            return SectionType.description.height
            
        case SectionType.currently.rawValue:
            return SectionType.currently.height
            
        default:
            return 40
        }
    }
}


