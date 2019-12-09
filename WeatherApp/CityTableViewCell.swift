//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by Dima Surkov on 06.12.2019.
//  Copyright © 2019 Dima Surkov. All rights reserved.
//

import UIKit

final class CityTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    static let identifier: String = "identifier"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .thin)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        makeLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    
    func configure(with city: Storage.City) {
        nameLabel.text = city.name
    }
    
    // MARK: - Layout
    
    private func makeLayout() {
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.top.equalToSuperview()
        }
    }
}
