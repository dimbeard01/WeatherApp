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
    var chosenCity: Storage.City? {
        didSet {
            guard let city = chosenCity else { return }
            fetchWeatherForecast(
                cityLatitude: city.coordinate.latitude,
                cityLongitude: city.coordinate.longitude)
        }
    }
    
    let collectionView = CityWeatherCollectionView()

    private let pageControlSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .white
        return separator
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
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
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        super.loadView()
//        view = backgroundImageView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        makeLayout()
        setupCollectionView()
    }
   
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Support

    private func setupCollectionView() {
        collectionView.onPageChanged = { [weak self] page in
            self?.currentPage = page
            self?.pageControl.currentPage = page
        }
    }
    
    // MARK: - Request
    
    private func fetchWeatherForecast(cityLatitude: Double, cityLongitude: Double) {
        let coordinate: CLLocationCoordinate2D = .init(latitude: cityLatitude, longitude: cityLongitude)
        Network.shared.fetchWeatherForecast(coordinate: coordinate) { [weak self] forecast in
            if let forecast = forecast {
                self?.forecasts.append(forecast)
            }
        }
    }
    
    // MARK: - Layout

    private func makeLayout() {
        [containerView, collectionView].forEach { view.addSubview($0) }
        [pageControl, addButton, removeButton, pageControlSeparator].forEach { containerView.addSubview($0) }

        containerView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(64)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalTo(containerView.snp.top)
        }
        
        pageControlSeparator.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }
        
        pageControl.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        removeButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
            $0.height.width.equalTo(44)
        }
        
        addButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(10)
            $0.height.width.equalTo(44)
        }
    }
    
    // MARK: - Actions
    
    @objc private func onDelete() {
        guard forecasts.indices.contains(currentPage) else { return }
        forecasts.remove(at: currentPage)
        // TODO: Unselect table view cell after delete
        collectionView.deleteItems(at: [IndexPath(item: currentPage, section: 0)])
    }
    
    @objc private func onAddCity() {
        let citiesTableViewController = CitiesTableViewController()
        citiesTableViewController.onSelectCity = { [weak self] city in
            self?.chosenCity = city
        }
        
        present(citiesTableViewController, animated: true)
    }
}
