//
//  HomeHeaderView.swift
//  Starbucks
//
//  Created by Oguz Mert Beyoglu on 12.10.2024.
//

import Foundation
import UIKit

class HomeHeaderView: UIView {
    
    let greeting        = UILabel()
    let inboxButton     = UIButton(type: .custom)
    let inboxImageView  = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeHeaderView {
    func style() {
        translatesAutoresizingMaskIntoConstraints               = false
        
        greeting.translatesAutoresizingMaskIntoConstraints      = false
        greeting.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        greeting.text = "Günaydın. Bugün nasılsın Mert? 🌞"
        greeting.numberOfLines = 0
        greeting.lineBreakMode = .byWordWrapping
        
        
        inboxButton.translatesAutoresizingMaskIntoConstraints   = false
        inboxButton.setTitle("Inbox", for: [])
        inboxButton.setTitleColor(.secondaryLabel, for: [])
        inboxButton.contentMode     = .scaleAspectFit
        
        inboxImageView.translatesAutoresizingMaskIntoConstraints = false
        inboxImageView.image        = UIImage(systemName: "envelope")
        inboxImageView.tintColor    = .secondaryLabel
        inboxImageView.contentMode  = .scaleAspectFit
        
    }
    
    func layout() {
        addSubview(greeting)
        addSubview(inboxImageView)
        addSubview(inboxButton)
        
        
        // Greeting Label
        NSLayoutConstraint.activate([
            greeting.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            greeting.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: greeting.trailingAnchor, multiplier: 1)
        ])
        
        
        // Inbox Button with Image
        NSLayoutConstraint.activate([
            inboxImageView.topAnchor.constraint(equalToSystemSpacingBelow: greeting.safeAreaLayoutGuide.bottomAnchor, multiplier: 2),
            inboxImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: safeAreaLayoutGuide.leadingAnchor, multiplier: 2),
            inboxButton.centerYAnchor.constraint(equalTo: inboxImageView.centerYAnchor),
            inboxButton.leadingAnchor.constraint(equalTo: inboxImageView.trailingAnchor, constant: 1.5),
            bottomAnchor.constraint(equalToSystemSpacingBelow: inboxImageView.bottomAnchor, multiplier: 1),
        ])
        
    }
}
