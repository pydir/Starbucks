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
        TileView("Star Balance"),
        TileView("Bonus Star"),
        TileView("Try These"),
        TileView("Welcome Back"),
        TileView("Uplifting")
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
//        headerView.backgroundColor = appColor
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints  = false
        stackView.axis      = .vertical
        stackView.spacing   = 8
        
        
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
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
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
