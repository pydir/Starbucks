//
//  RewardTileView.swift
//  Starbucks
//
//  Created by Oguz Mert Beyoglu on 13.10.2024.
//

import UIKit

class RewardsTileView: UIView {
    let balanceView      = BalanceView()
    var rewardsButton    = UIButton()
    let rewardsGraphView = RewardsGraphView()
    let starRewardsView  = UIView()
    var detailsButton    = UIButton()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 300)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .tertiarySystemFill
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension RewardsTileView {
    private func style() {
        balanceView.translatesAutoresizingMaskIntoConstraints       = false
        starRewardsView.translatesAutoresizingMaskIntoConstraints   = false
        
        rewardsButton.translatesAutoresizingMaskIntoConstraints     = false
        let imageConfig = UIImage.SymbolConfiguration(scale: .small)
        var rewardsButtonConfig = UIButton.Configuration.borderless()
        let image = UIImage(systemName: "chevron.down", withConfiguration: imageConfig)!
        rewardsButtonConfig.image           = image.withTintColor(.label, renderingMode: .alwaysOriginal)
        rewardsButtonConfig.imagePlacement  = .trailing
        rewardsButtonConfig.imagePadding    = 8
        
        rewardsButtonConfig.attributedTitle = AttributedString("Rewards options", attributes: AttributeContainer([
            NSAttributedString.Key.font : UIFont.preferredFont(forTextStyle: .footnote),
            NSAttributedString.Key.foregroundColor: UIColor.label,
        ]))
        
        rewardsButton.configuration         = rewardsButtonConfig
        rewardsButton.addTarget(self, action: #selector(rewardsOptionsTapped), for: .primaryActionTriggered)
        
        rewardsGraphView.translatesAutoresizingMaskIntoConstraints  = false
//        rewardsGraphView.backgroundColor = .red
        
        detailsButton.translatesAutoresizingMaskIntoConstraints     = false
        detailsButton.setTitle("Details", for: [])
        detailsButton.setTitleColor(.label, for: [])
        var detailsButtonConfig = UIButton.Configuration.plain()
        detailsButtonConfig.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        detailsButton.layer.borderColor = UIColor.label.cgColor
        detailsButton.layer.borderWidth = 1
        detailsButton.layer.cornerRadius = 18
        detailsButton.clipsToBounds = true
        detailsButton.configuration = detailsButtonConfig
    }
    
    @objc private func rewardsOptionsTapped(_ sender: UIButton) {
        sender.titleLabel?.font = UIFont.preferredFont(forTextStyle: .extraLargeTitle2)
    }
    
    private func layout() {
        addSubview(balanceView)
        addSubview(rewardsButton)
        addSubview(rewardsGraphView)
        addSubview(starRewardsView)
        addSubview(detailsButton)
        
        NSLayoutConstraint.activate([
            balanceView.topAnchor.constraint(equalTo: topAnchor),
            balanceView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            rewardsButton.centerYAnchor.constraint(equalTo: balanceView.pointsLabel.centerYAnchor),
            trailingAnchor.constraint(equalToSystemSpacingAfter: rewardsButton.trailingAnchor, multiplier: 2)
        ])
        
        NSLayoutConstraint.activate([
            rewardsGraphView.topAnchor.constraint(equalToSystemSpacingBelow: balanceView.bottomAnchor, multiplier: 1),
            rewardsGraphView.centerXAnchor.constraint(equalTo: centerXAnchor),
            rewardsGraphView.widthAnchor.constraint(equalToConstant: frame.width),
            rewardsGraphView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: rewardsGraphView.trailingAnchor, multiplier: 2)
        ])
        
        NSLayoutConstraint.activate([
            starRewardsView.topAnchor.constraint(equalTo: rewardsGraphView.bottomAnchor, constant: 8),
            starRewardsView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: starRewardsView.trailingAnchor, multiplier: 1),
        ])
        
        NSLayoutConstraint.activate([
            detailsButton.topAnchor.constraint(equalToSystemSpacingBelow: starRewardsView.bottomAnchor, multiplier: 2),
            detailsButton.leadingAnchor.constraint(equalToSystemSpacingAfter: balanceView.leadingAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: detailsButton.bottomAnchor, multiplier: 2)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rewardsGraphView.actualFrameWidth = frame.width
        rewardsGraphView.drawRewardsGraph()
    }
}
