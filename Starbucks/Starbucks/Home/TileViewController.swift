//
//  TileViewController.swift
//  Starbucks
//
//  Created by Oguz Mert Beyoglu on 13.10.2024.
//

import Foundation
import UIKit

class TileViewController: UIViewController {
    let tileView = TileView()
    
    init(title: String, subtitle: String, imageName: String) {
        super.init(nibName: nil, bundle: nil)
        tileView.titleLabel.text = title
        tileView.descriptionLabel.text = subtitle
        tileView.imageView.image = UIImage(named: imageName)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TileViewController {
    private func style() {
        tileView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        view.addSubview(tileView)
        
        NSLayoutConstraint.activate([
            tileView.topAnchor.constraint(equalTo: view.topAnchor),
            tileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tileView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
