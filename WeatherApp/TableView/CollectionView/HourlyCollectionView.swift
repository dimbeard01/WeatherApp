//
//  HourlyCollectionView.swift
//  WeatherApp
//
//  Created by Dima Surkov on 28.11.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

import UIKit

final class HourlyCollectionView: UICollectionView {
    
    // MARK: - Properties

    var model: WeatherForecastViewModel? {
        didSet {
            reloadData()
        }
    }
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private let topSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let bottomSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let wrapperBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    // MARK: - Init

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        
        register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: HourlyCollectionViewCell.hourlyCellID)
        dataSource = self
        delegate = self
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
        makeLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout

    private func makeLayout() {
        backgroundView = wrapperBackgroundView
        wrapperBackgroundView.addSubview(bottomSeparator)
        wrapperBackgroundView.addSubview(topSeparator)
        
        topSeparator.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }
        
        bottomSeparator.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
}

    // MARK: - Collection view data source

extension HourlyCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.hourlyCellID, for: indexPath) as? HourlyCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(with: model?.hoursList[indexPath.item], indexPath: indexPath)
        return cell
    }
    
}

    // MARK: - Collection view delegate flow layout

extension HourlyCollectionView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: 70, height: collectionView.bounds.height)
        } else {
            return CGSize(width: 64, height: collectionView.bounds.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
