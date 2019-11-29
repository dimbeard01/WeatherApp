//
//  HeaderView.swift
//  WeatherApp
//
//  Created by Dima Surkov on 22.11.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    // MARK: - Properties

    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.3321021472, green: 0.3457777109, blue: 0.6376527342, alpha: 1)
        view.alpha = 0.3
        return view
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        label.text = "Omsk"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout

    func makeLayout() {
        addSubview(headerView)
        addSubview(cityLabel)
        
        headerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cityLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.centerY.equalTo(headerView.snp.centerY)
        }
    }
}
