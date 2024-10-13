//
//  HomeViewController.swift
//  Starbucks
//
//  Created by Oguz Mert Beyoglu on 12.10.2024.
//

import UIKit

class HomeViewController: UIViewController {
    let headerView  = HomeHeaderView()
    let scrollView  = UIScrollView()
    let stackView   = UIStackView()
    
    var headerViewTopConstraint: NSLayoutConstraint?
    
    let tiles   = [
        RewardsTileViewController(),
        TileViewController(title: "Breakfast made meatless", subtitle: "Try the beyond Meta, Cheddar & Egg Breakfast Sandwich. Vegeterian and protein-packed.", imageName: "meatless"),
        TileViewController(title: "Uplifting our communites", subtitle: "Thanks to our partners nominations. The Stackbucks Foundation is donating $521K to more than 200 charities.", imageName: "communities"),
        TileViewController(title: "Spend at least $15 for 50 bonus stars.", subtitle: "Collect 50 Bonus Stars when you spend at least $15 pre-tax", imageName: "bonus"),
    ]
     
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension HomeViewController {
    private func setup() {
        
        setupScrollView()
        
        style()
        layout()
    }
    
    private func style() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints  = false
        stackView.axis      = .vertical
        stackView.spacing   = 18
        
        
    }
    
    private func layout() {
        view.addSubview(headerView)
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        for tile in tiles {
            addChild(tile)
            stackView.addArrangedSubview(tile.view)
            tile.didMove(toParent: self)
        }
        
        headerViewTopConstraint = headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        headerViewTopConstraint?.isActive = true
        
        
        // header view
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            
        ])
        
        // scroll view
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // stack view
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}

// MARK: - Animating Scroll View
extension HomeViewController: UIScrollViewDelegate {
    
    private func setupScrollView() {
        scrollView.delegate = self
    }
    
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        
        let swipingDown = y <= 0
        let shouldSnap  = y > 30
        let labelHeight = headerView.greeting.frame.height + 20
        
        UIView.animate(withDuration: 0.2) {
            self.headerView.greeting.alpha = swipingDown ? 1.0 : 0.0
        }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0) {
            self.headerViewTopConstraint?.constant = shouldSnap ? -labelHeight : 0
            self.view.layoutIfNeeded()
        }
    }
}
