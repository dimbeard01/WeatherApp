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
    
    var forecasts: [NetworkWeatherForecast] = [] {
        didSet {
            collectionView.model = forecasts
            DispatchQueue.main.async {
                self.pageControl.numberOfPages = self.forecasts.count
            }
        }
    }
    
    var currentPage: Int = 0 {
        didSet {
            print(currentPage)
        }
    }

    private let collectionView = CityWeatherCollectionView()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.tintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.numberOfPages = forecasts.count
        pageControl.currentPage = currentPage
        return pageControl
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(onDelete), for: .touchUpInside)
        button.backgroundColor = .blue
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(onAddCity), for: .touchUpInside)
        button.backgroundColor = .red
        return button
    }()
    
    @objc private func onDelete() {
        guard forecasts.indices.contains(currentPage) else { return }
        forecasts.remove(at: currentPage)
        collectionView.deleteItems(at: [IndexPath(item: currentPage, section: 0)])
    }
    
    @objc private func onAddCity() {
        fetchWeatherForecast()
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "back"))
        makeLayout()
        fetchWeatherForecast()
        
        view.addSubview(button)
        button.frame = CGRect(x: 200, y: 200, width: 200, height: 200)
        setupCollectionView()
        
        view.addSubview(plusButton)
        plusButton.frame = CGRect(x: 200, y: 400, width: 200, height: 200)
    }
    
    private func setupCollectionView() {
        collectionView.onPageChanged = { [weak self] page in
            self?.currentPage = page
            self?.pageControl.currentPage = page
        }
    }
    
    // MARK: - Request
    
    func fetchWeatherForecast() {
        let coordinate: CLLocationCoordinate2D = .init(latitude: 55.041986, longitude: 82.967978)
        Network.shared.fetchWeatherForecast(coordinate: coordinate) { [weak self] forecast in
            if let forecast = forecast {
                self?.forecasts.append(forecast)
            }
        }
        
        Network.shared.fetchWeatherForecast(coordinate: coordinate) { [weak self] forecast in
            if let forecast = forecast {
                self?.forecasts.append(forecast)
            }
        }

        Network.shared.fetchWeatherForecast(coordinate: coordinate) { [weak self] forecast in
            if let forecast = forecast {
                self?.forecasts.append(forecast)
            }
        }

    }
    
    // MARK: - Layout

    func makeLayout() {
        view.addSubview(collectionView)
        view.addSubview(pageControl)

        collectionView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalTo(pageControl.snp.top)
        }
        
        pageControl.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
}
