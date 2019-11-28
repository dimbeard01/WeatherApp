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
    
    enum cellType: Int {
        case dailyCell = 0
        case currentDescriptionCell
        case currentlyCell
        
        func getHeight() -> CGFloat {
            switch self {
            case .dailyCell:
                return 30
            case .currentDescriptionCell:
                return UITableView.automaticDimension
            case .currentlyCell:
                return 60
            }
        }
        
    }
    
    enum sectionType: Int {
        case daily = 0
        case currentSummary
        case currently
    }
    
    private let dailyCellID: String = "dailyCellID"
    private let currentlyCellID: String = "currentlyCellID"
    private let currentDescriptionCellID: String = "currentDescriptionCellID"

    private var weatherModel: WeatherForecastViewModel?
    private var header = HeaderView()


    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(DailyCell.self, forCellReuseIdentifier: dailyCellID)
        tableView.register(CurrentDescriptionCell.self, forCellReuseIdentifier: currentDescriptionCellID)
        tableView.register(CurrentlyCell.self, forCellReuseIdentifier: currentlyCellID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchWeatherForecast()
        
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "back"))
        view.addSubview(header.headerView)
        view.addSubview(header.cityLabel)
        header.makeLayout()
        view.addSubview(tableView)

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.snp.makeConstraints {
            $0.top.equalTo(header.headerView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }


    // MARK: - Support

private func fetchWeatherForecast() {
    WeatherItemController.shared.fetchWeatherForecast { [weak self] (forecast) in
        if let forecast = forecast {
            DispatchQueue.main.async {
                print(forecast)
                self?.updateUI(with: forecast)
            }
        }
    }
}
    
    private func updateUI(with data: WeatherForecast) {
        DispatchQueue.main.async {
            let s = WeatherForecastViewModel(with: data)
            self.weatherModel = s
            self.tableView.reloadData()
        }
    }
}

    // MARK: - Table view data source

extension WeatherForecastController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let model = weatherModel else { return 0 }
    
        switch section {
        case sectionType.daily.rawValue:
            return model.daysList.count
            
        case sectionType.currentSummary.rawValue:
            return 1
            
        case sectionType.currently.rawValue:
            return model.currentConditionsList.count
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let model = weatherModel else { return UITableViewCell() }

        switch indexPath.section {
        case cellType.dailyCell.rawValue:
            let cell = DailyCell()
            let data = model.daysList[indexPath.row]
            cell.configure(with: data)
            tableView.separatorStyle = .none
            cell.selectionStyle = .none
            return cell
            
        case cellType.currentDescriptionCell.rawValue:
            let cell = CurrentDescriptionCell()
            let data = model.currentDescription
            cell.configure(with: data)
            tableView.separatorStyle = .none
            cell.selectionStyle = .none
            return cell
            
        case cellType.currentlyCell.rawValue:
            let cell = CurrentlyCell()
            let data = model.currentConditionsList[indexPath.row]
            cell.configure(with: data, indexPath: indexPath.row)
            tableView.separatorStyle = .none
            cell.selectionStyle = .none
            return cell
        
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case sectionType.daily.rawValue:
            return "HEADER"
            
        default:
            return nil
        }
    }
}

    // MARK: - Table view delegate

extension WeatherForecastController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case sectionType.daily.rawValue:
            return 80
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case cellType.dailyCell.rawValue:
            return cellType.dailyCell.getHeight()
            
        case cellType.currentDescriptionCell.rawValue:
            return cellType.currentDescriptionCell.getHeight()
            
        case cellType.currentlyCell.rawValue:
            return cellType.currentlyCell.getHeight()
            
        default:
            return 40
        }
    }
}
    

