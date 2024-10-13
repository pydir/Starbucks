//
//  RewardsTileViewController.swift
//  Starbucks
//
//  Created by Oguz Mert Beyoglu on 13.10.2024.
//
import UIKit

class RewardsTileViewController : UIViewController {
    let rewardsTileView = RewardsTileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension RewardsTileViewController {
    
    private func style() {
        rewardsTileView.delegate = self
        rewardsTileView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        view.addSubview(rewardsTileView)
        
        NSLayoutConstraint.activate([
            rewardsTileView.topAnchor.constraint(equalTo: view.topAnchor),
            rewardsTileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: rewardsTileView.trailingAnchor),
            rewardsTileView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension RewardsTileViewController: RewardsTileViewDelegate {
    func didHistoryDetailsButtonTapped(_ sender: UIButton) {
        let navController = UINavigationController(rootViewController: HistoryViewController())
        navController.navigationBar.prefersLargeTitles = true
        present(navController, animated: true)
    }
}
