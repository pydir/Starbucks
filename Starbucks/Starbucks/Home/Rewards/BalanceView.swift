//
//  BalanceView.swift
//  Starbucks
//
//  Created by Oguz Mert Beyoglu on 13.10.2024.
//

import UIKit

class BalanceView: UIView {
    let pointsLabel         = UILabel()
    let starView            = UIComponentMakers.makeSymbolImageView(systemName: "star.fill")
    let starBalanceLabel    = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BalanceView {
    
    private func style() {
        pointsLabel.translatesAutoresizingMaskIntoConstraints       = false
        pointsLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle).bold()
        pointsLabel.text = "87"
        
        starView.translatesAutoresizingMaskIntoConstraints          = false
        starView.tintColor = UIColor.starYellow
        starView.contentMode = .scaleAspectFit
        
        starBalanceLabel.translatesAutoresizingMaskIntoConstraints  = false
        starBalanceLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        starBalanceLabel.textColor = .label
        starBalanceLabel.text = "Star balance"
    }
    
    private func layout() {
        addSubview(pointsLabel)
        addSubview(starView)
        addSubview(starBalanceLabel)
        
        NSLayoutConstraint.activate([
            pointsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            pointsLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
        ])
        
        NSLayoutConstraint.activate([
            starView.leadingAnchor.constraint(equalTo: pointsLabel.trailingAnchor, constant: -2),
            starView.centerYAnchor.constraint(equalTo: pointsLabel.centerYAnchor, constant: 4),
            starView.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        NSLayoutConstraint.activate([
            starBalanceLabel.topAnchor.constraint(equalTo: pointsLabel.bottomAnchor),
            starBalanceLabel.leadingAnchor.constraint(equalTo: pointsLabel.leadingAnchor),
            starBalanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            starBalanceLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
}
