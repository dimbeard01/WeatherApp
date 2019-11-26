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
    
    enum cellType: Int {
        case dailyCell = 0
        case currentlyCell
        
        func getHeight() -> CGFloat {
            switch self {
            case .dailyCell:
                return 40
            case .currentlyCell:
                return 80
            }
        }
        
    }
    
    enum sectionType: Int {
        case daily = 0
        case currently
    }
    
    let array = [["","","","","","","",""],["","","","","","","",""]]
    
    private let dailyCellID: String = "dailyCellID"
    private let currentlyCellID: String = "currentlyCellID"
    private let hourlyCellID: String = "hourlyCellID"

    var dailyConditionsList = [DailyConditionsList]()
    var currentlyConditionsList = [CurrentWeatherConditions]()
    
    var newArray: CurrentConditionList?
    
    var header = HeaderView()

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(DailyTableViewCell.self, forCellReuseIdentifier: dailyCellID)
        tableView.register(CurrentlyTableViewCell.self, forCellReuseIdentifier: currentlyCellID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
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
                self?.updateUI(with: forecast)
            }
        }
    }
}
    
    private func updateUI(with day: WeatherForecast) {
        DispatchQueue.main.async {
            self.dailyConditionsList = day.daily.data
            self.currentlyConditionsList.append(day.currently)
            self.newArray = CurrentConditionList(arrey: day.currently)
            self.tableView.reloadData()
        }
    }
}

    // MARK: - Table view data source

extension WeatherForecastController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case sectionType.daily.rawValue:
            return dailyConditionsList.count
        case sectionType.currently.rawValue:
            return newArray?.arrey.count ?? 0
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case cellType.dailyCell.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: dailyCellID, for: indexPath) as? DailyTableViewCell else { return UITableViewCell() }
            let today = dailyConditionsList[indexPath.row]
            tableView.separatorStyle = .none
            cell.configure(with: today)
            cell.selectionStyle = .none
            return cell
            
        case cellType.currentlyCell.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: currentlyCellID, for: indexPath) as? CurrentlyTableViewCell else { return UITableViewCell() }
            guard let current = newArray else {return UITableViewCell()}
            let cur = current.arrey[indexPath.row]
            print("****************************************")
            print(indexPath.row)
            print("****************************************")
            cell.configure(with: cur, indexPath: indexPath.row)
            tableView.separatorStyle = .singleLine
            tableView.separatorInset = UIEdgeInsets(top: -66, left: 40, bottom: 0, right: 40)
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
        case cellType.currentlyCell.rawValue:
            return cellType.currentlyCell.getHeight()
        default:
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case cellType.dailyCell.rawValue:
            return 0
        case cellType.currentlyCell.rawValue:
            return 0
        default:
            return 0
        }
    }
    
}

    // MARK: - Table view delegate
extension WeatherForecastController: UITableViewDelegate {
    
}
    

