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
    
    //MARK: - Properties
    
    private let dailyCellID: String = "dailyCellID"
    private let currentlyCellID: String = "currentlyCellID"
    private let hourlyCellID: String = "hourlyCellID"

    var dailyConditions = [DailyConditionsList]()
    var header = HeaderView()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(DailyTableViewCell.self, forCellReuseIdentifier: dailyCellID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    //MARK: - LifeCycle
    
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
      
        tableView.frame = CGRect(
            x: 0,
            y: header.headerView.frame.height,
            width: view.frame.width,
            height: view.frame.height)
    }


    // MARK: - Support

private func fetchWeatherForecast() {
    WeatherItemController.shared.fetchWeatherForecast { [weak self] (forecast) in
        if let forecast = forecast {
            DispatchQueue.main.async {
                self?.updateUI(with: forecast.daily.data)
            }
        }
    }
}
    
    private func updateUI(with day: [DailyConditionsList]) {
        DispatchQueue.main.async {
            self.dailyConditions = day
            self.tableView.reloadData()
        }
    }
}

    // MARK: - Table view data source

extension WeatherForecastController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyConditions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: dailyCellID, for: indexPath) as? DailyTableViewCell else {
            return DailyTableViewCell()
        }
        
        let today = dailyConditions[indexPath.row]
        cell.configure(with: today)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "HEADER"
    }
    
}

    // MARK: - Table view delegate
extension WeatherForecastController: UITableViewDelegate {
    
}
    

