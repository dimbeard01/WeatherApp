//
//  CitiesTableViewController.swift
//  WeatherApp
//
//  Created by Dima Surkov on 06.12.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

import UIKit

final class CitiesTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var onSelectCity: ((Storage.City) -> Void)?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    // MARK: - Support

    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Storage.shared.cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else { return UITableViewCell() }
        
        let city = Storage.shared.cities[indexPath.row]
        cell.configure(with: city)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cell.isUserInteractionEnabled = city.chosen ? false : true
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        Storage.shared.cities[indexPath.row].chosen = true
        onSelectCity?(Storage.shared.cities[indexPath.row])
        print(Storage.shared.cities[indexPath.row])
        
        dismiss(animated: true)
    }
}
