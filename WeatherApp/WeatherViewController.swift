//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Dima Surkov on 05.12.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

import UIKit
import SnapKit
import CoreLocation

final class WeatherViewController: UIViewController {
    
    // MARK: - Properties
    
    var forecasts: [WeatherForecastViewModel] = [] {
        didSet {
            collectionView.model = forecasts
            DispatchQueue.main.async {
                self.pageControl.numberOfPages = self.forecasts.count
            }
        }
    }
    
    var currentPage: Int = 0
    var addedCityIndex: [IndexPath] = []
    let collectionView = CityWeatherCollectionView()

    private let pageControlSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .white
        return separator
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.tintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.isUserInteractionEnabled = false
        pageControl.numberOfPages = forecasts.count
        pageControl.currentPage = currentPage
        return pageControl
    }()
    
    private lazy var removeButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(onDelete), for: .touchUpInside)
        button.setImage(UIImage(named: "remove"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(onAddCity), for: .touchUpInside)
        button.setImage(UIImage(named: "add"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "back"))
        makeLayout()
        setupCollectionView()
    }
    
    // MARK: - Public

     func scrollToNewItem() {
        let indexPath = IndexPath(item: forecasts.endIndex - 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        collectionView.setNeedsLayout()
    }
    
    // MARK: - Support

    private func setupCollectionView() {
        collectionView.onPageChanged = { [weak self] page in
            self?.currentPage = page
            self?.pageControl.currentPage = page
        }
    }
    
    // MARK: - Request
    
    func fetchWeatherForecast(cityLatitude: Double, cityLongitude: Double) {
        let coordinate: CLLocationCoordinate2D = .init(latitude: cityLatitude, longitude: cityLongitude)
        Network.shared.fetchWeatherForecast(coordinate: coordinate) { [weak self] forecast in
            if let forecast = forecast {
                self?.forecasts.append(forecast)
            }
        }
    }
    
    // MARK: - Layout

    func makeLayout() {
        [collectionView, pageControlSeparator, pageControl, removeButton, addButton].forEach { view.addSubview($0) }

        collectionView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalTo(pageControl.snp.top)
        }
        
        pageControlSeparator.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(pageControl.snp.top)
            $0.height.equalTo(0.5)
        }
        
        pageControl.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        removeButton.snp.makeConstraints {
            $0.top.equalTo(pageControl.snp.top).offset(10)
            $0.leading.equalTo(pageControl.snp.leading).offset(10)
            $0.bottom.equalTo(pageControl.snp.bottom).offset(-10)
            $0.height.width.equalTo(30)
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(pageControl.snp.top).offset(10)
            $0.trailing.equalTo(pageControl.snp.trailing).offset(-10)
            $0.bottom.equalTo(pageControl.snp.bottom).offset(-10)
            $0.height.width.equalTo(30)
        }
    }
    
    // MARK: - Actions
    
    @objc private func onDelete() {
        guard forecasts.indices.contains(currentPage) else { return }
        forecasts.remove(at: currentPage)
        addedCityIndex.remove(at: currentPage)
        collectionView.deleteItems(at: [IndexPath(item: currentPage, section: 0)])
    }
    
    @objc private func onAddCity() {
        let citiesTableViewController = CitiesTableViewController()
        citiesTableViewController.weatherViewController = self
        present(citiesTableViewController, animated: true, completion: nil)
    }
}
