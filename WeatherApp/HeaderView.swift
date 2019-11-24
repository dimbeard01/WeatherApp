//
//  HeaderView.swift
//  WeatherApp
//
//  Created by Dima Surkov on 22.11.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

    // MARK: - WIP

import UIKit

class HeaderView: UIView {
    
    // MARK: - Properties

    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.3321021472, green: 0.3457777109, blue: 0.6376527342, alpha: 1)
        view.alpha = 0.3
        return view
    }()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.text = "Omsk"
        return label
    }()
    
    // MARK: - Layout

    func makeLayout() {
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(100)
            
        cityLabel.snp.makeConstraints {
            $0.centerX.equalTo(headerView.snp.centerX)
            $0.centerY.equalTo(headerView.snp.centerY)
            }
        }
    }
}
