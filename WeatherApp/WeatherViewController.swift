//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Dima Surkov on 05.12.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

import UIKit
import SnapKit

final class WeatherViewController: UIViewController {
    
    // MARK: - Properties

    private let collectionView = CityWeatherCollectionView()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.tintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.numberOfPages = 5
        pageControl.currentPage = 0
        return pageControl
    }()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "back"))
        makeLayout()
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
