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
    private var headerView = HeaderView()
    private var collectionHeader = HourlyCollectionView()
    private var currentHeight: CGFloat = 140
    private lazy var heightConstraint: NSLayoutConstraint = {
        let constraint = NSLayoutConstraint(
            item: headerView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .height,
            multiplier: 1,
            constant: currentHeight)
        return constraint
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(DailyTableViewCell.self, forCellReuseIdentifier: DailyTableViewCell.dailyCellID)
        tableView.register(CurrentDescriptionCell.self, forCellReuseIdentifier: CurrentDescriptionCell.identifier)
        tableView.register(CurrentlyCell.self, forCellReuseIdentifier: CurrentlyCell.currentlyCellID)
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
    
    private func makeLayout() {
        view.addSubview(headerView)
        view.addSubview(tableView)
        
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
        heightConstraint.isActive = true
        
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(currentHeight)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        collectionHeader.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 150)
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
    
    private func updateUI(with data: WeatherForecast) {
        DispatchQueue.main.async {
            let model = WeatherForecastViewModel(with: data)
            self.collectionHeader.model = model
            self.weatherModel = model
            self.tableView.reloadData()
        }
    }
}

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
         
         func getHeight() -> CGFloat {
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
    
    // MARK: - Setup Cells
    
    private func currentlyCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentlyCell.currentlyCellID, for: indexPath) as? CurrentlyCell else { return UITableViewCell() }
        guard let model = weatherModel else { return UITableViewCell() }
        
        let cellModel = model.currentConditionsList[indexPath.row]
        cell.configure(with: cellModel, indexPath: indexPath.row)

        return cell
    }
    
    private func descriptionCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentDescriptionCell.identifier, for: indexPath) as? CurrentDescriptionCell else { return UITableViewCell() }
        guard let model = weatherModel else { return UITableViewCell() }
    
        let cellModel = model.currentDescription
        cell.configure(with: cellModel)

        return cell
    }
    
    private func dailyCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.dailyCellID, for: indexPath) as? DailyTableViewCell else { return UITableViewCell() }
        guard let model = weatherModel else { return UITableViewCell() }
    
        let cellModel = model.daysList[indexPath.row]
        cell.configure(with: cellModel)

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
            return SectionType.description.getHeight()
            
        case SectionType.currently.rawValue:
            return SectionType.currently.getHeight()
            
        default:
            return 40
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        heightConstraint.constant += -scrollView.contentOffset.y
    }

}
    

