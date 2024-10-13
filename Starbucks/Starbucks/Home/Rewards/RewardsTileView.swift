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
    let starRewardsView  = StarRewardsView()
    var detailsButton    = UIButton()
    
    var heightConstraints: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        detailsButton.addTarget(self, action: #selector(detailsButtonTapped), for: .primaryActionTriggered)
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
            rewardsGraphView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: rewardsGraphView.trailingAnchor, multiplier: 2)
        ])
        
        heightConstraints = starRewardsView.heightAnchor.constraint(equalToConstant: 0)
        NSLayoutConstraint.activate([
            starRewardsView.topAnchor.constraint(equalTo: rewardsGraphView.bottomAnchor, constant: 8),
            starRewardsView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: starRewardsView.trailingAnchor, multiplier: 2),
            heightConstraints!
        ])
        
        NSLayoutConstraint.activate([
            detailsButton.topAnchor.constraint(equalToSystemSpacingBelow: starRewardsView.bottomAnchor, multiplier: 2),
            detailsButton.leadingAnchor.constraint(equalToSystemSpacingAfter: balanceView.leadingAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: detailsButton.bottomAnchor, multiplier: 2)
        ])
        
        starRewardsView.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rewardsGraphView.actualFrameWidth = frame.width
        rewardsGraphView.drawRewardsGraph()
    }
}

// MARK: - Actions
extension RewardsTileView {
    @objc private func rewardsOptionsTapped(_ sender: UIButton) {
        if heightConstraints?.constant == 0 {
            self.setChevronUp()
            
            let heightAnimator = UIViewPropertyAnimator(duration: 0.7, curve: .easeInOut) {
                self.heightConstraints?.constant = 270
                self.layoutIfNeeded()
            }
            
            heightAnimator.startAnimation()
            
            let alphaAnimator = UIViewPropertyAnimator(duration: 0.25, curve: .easeInOut) {
                self.starRewardsView.isHidden = false
                self.starRewardsView.alpha = 1
            }
            
            alphaAnimator.startAnimation(afterDelay: 0.5)
        } else {
            self.setChevronDown()
            
            let animator = UIViewPropertyAnimator(duration: 0.7, curve: .easeInOut) {
                self.heightConstraints?.constant = 0
                self.starRewardsView.isHidden = true
                self.starRewardsView.alpha = 0
                self.layoutIfNeeded()
            }
            animator.startAnimation()
        }
    }
    
    @objc private func detailsButtonTapped(_ sender: UIButton) {
        print("Details tapped!")
    }
    
    private func setChevronUp() {
        let configuration = UIImage.SymbolConfiguration(scale: .small)
        let image = UIImage(systemName: "chevron.up", withConfiguration: configuration)!.withTintColor(.label, renderingMode: .alwaysOriginal)
        rewardsButton.setImage(image, for: .normal)
    }
    
    private func setChevronDown() {
        let configuration = UIImage.SymbolConfiguration(scale: .small)
        let image = UIImage(systemName: "chevron.down", withConfiguration: configuration)!.withTintColor(.label, renderingMode: .alwaysOriginal)
        rewardsButton.setImage(image, for: .normal)
    }
}
