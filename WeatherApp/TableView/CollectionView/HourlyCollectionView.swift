//
//  HourlyCollectionView.swift
//  WeatherApp
//
//  Created by Dima Surkov on 28.11.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

import UIKit

class HourlyCollectionView: UICollectionView {
    
    var data: WeatherForecastViewModel?
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        return layout
    }()
    
    init() {
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        register(HourlyCell.self, forCellWithReuseIdentifier: HourlyCell.hourlyCellID)
        dataSource = self
        delegate = self
        backgroundColor = .yellow
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HourlyCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = data else {  fatalError("No data ") }
        return data.hoursList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let data = data else { return UICollectionViewCell() }

        let cell = HourlyCell()
        cell.configure(with: data.hoursList[indexPath.item])
        return cell
    }
    
}


extension HourlyCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 150
        let width: CGFloat = 320
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
