//
//  CityWeatherCollectionView.swift
//  WeatherApp
//
//  Created by Dima Surkov on 05.12.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

import UIKit

final class CityWeatherCollectionView: UICollectionView {
    
    // MARK: - Properties
    
    var onPageChanged: ((Int) -> Void)?
    
    var model: [NetworkWeatherForecast]? {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }

    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        
        register(CityWeatherCollectionViewCell.self, forCellWithReuseIdentifier: CityWeatherCollectionViewCell.identifier)
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
        isPagingEnabled = true
        dataSource = self
        delegate = self
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

    // MARK: - Collection view data source

extension CityWeatherCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityWeatherCollectionViewCell.identifier, for: indexPath) as? CityWeatherCollectionViewCell else { return UICollectionViewCell() }
        cell.model = model?[indexPath.item]
        return cell
    }
    
}

    // MARK: - Collection view delegate flow layout

extension CityWeatherCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        onPageChanged?(indexPath.item)
    }
    
}
