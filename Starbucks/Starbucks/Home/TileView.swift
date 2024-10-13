//
//  TileView.swift
//  Starbucks
//
//  Created by Oguz Mert Beyoglu on 13.10.2024.
//

import UIKit

class TileView: UIView {
    let imageView        = UIImageView()
    let titleLabel       = UILabel()
    let descriptionLabel = UILabel()
    let orderButton      = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        style()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 6
    private var fillColor: UIColor = .white
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addShadow()
    }
    
    func addShadow() {
        shadowLayer = CAShapeLayer()
        
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        shadowLayer.fillColor = fillColor.cgColor
        
        shadowLayer.shadowColor     = UIColor.black.cgColor
        shadowLayer.shadowPath      = shadowLayer.path
        shadowLayer.shadowOffset    = CGSize(width: 0, height: 1)
        shadowLayer.shadowOpacity   = 0.2
        shadowLayer.shadowRadius    = 1
        
        layer.insertSublayer(shadowLayer, at: 0)
    }
    
}

extension TileView {
    
    private func style() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode   = .scaleAspectFill
        imageView.clipsToBounds = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title3).bold()

        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        
        orderButton.translatesAutoresizingMaskIntoConstraints = false
        orderButton.setTitle("Order", for: .normal)
        orderButton.setTitleColor(.white, for: .normal)
        orderButton.tintColor = appColor
        let config = UIButton.Configuration.filled()
        orderButton.configuration = config
        orderButton.layer.cornerRadius = 20
        orderButton.clipsToBounds = true
        let insets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
        orderButton.configuration!.contentInsets  = insets
        orderButton.titleLabel?.adjustsFontSizeToFitWidth = true

        
        
        
    }
    
    private func layout() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(orderButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 2),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: titleLabel.trailingAnchor, multiplier: 2)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 2),
            descriptionLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: descriptionLabel.trailingAnchor, multiplier: 2),
        ])
        
        NSLayoutConstraint.activate([
            orderButton.topAnchor.constraint(equalToSystemSpacingBelow: descriptionLabel.bottomAnchor, multiplier: 2),
            orderButton.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: orderButton.bottomAnchor, multiplier: 2)
        ])
    }
}
