//
//  HomeViewController.swift
//  Starbucks
//
//  Created by Oguz Mert Beyoglu on 12.10.2024.
//

import UIKit

class HomeViewController: UIViewController {
    let topSpacerView = UIView()
    let headerView  = HomeHeaderView()
    let scrollView  = UIScrollView()
    let stackView   = UIStackView()
    let scanButton  = UIButton()
    
    struct ScanButtonSpacing {
        static let height: CGFloat = 60
        static let width: CGFloat = 170
    }
    
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
        view.backgroundColor = .backgroundWhite
        topSpacerView.backgroundColor = .white
        
        topSpacerView.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.translatesAutoresizingMaskIntoConstraints    = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints    = false
        
        stackView.translatesAutoresizingMaskIntoConstraints     = false
        stackView.axis      = .vertical
        stackView.spacing   = 18
        
        scanButton.translatesAutoresizingMaskIntoConstraints    = false
        scanButton.setTitle("Scan in Store", for: .normal)
        scanButton.titleLabel?.minimumScaleFactor = 0.5
        scanButton.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        scanButton.titleLabel?.adjustsFontSizeToFitWidth = true
        scanButton.backgroundColor = .lightGreen
        scanButton.setTitleColor(.white, for: .normal)
        scanButton.layer.cornerRadius = ScanButtonSpacing.height / 2
        scanButton.clipsToBounds = true
        
    }
    
    private func layout() {
        view.addSubview(topSpacerView)
        view.addSubview(headerView)
        view.addSubview(scrollView)
        view.addSubview(scanButton)
        
        scrollView.addSubview(stackView)
        
        for tile in tiles {
            addChild(tile)
            stackView.addArrangedSubview(tile.view)
            tile.didMove(toParent: self)
        }
        
        headerViewTopConstraint = headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        headerViewTopConstraint?.isActive = true
        
        // top view
        NSLayoutConstraint.activate([
            topSpacerView.topAnchor.constraint(equalTo: view.topAnchor),
            topSpacerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topSpacerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            topSpacerView.heightAnchor.constraint(equalToConstant: 100)
            topSpacerView.bottomAnchor.constraint(equalToSystemSpacingBelow: headerView.inboxButton.bottomAnchor, multiplier: 2)
        ])
        
        
        // header view
        NSLayoutConstraint.activate([
            headerViewTopConstraint!,
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
        
        // Scan button
        NSLayoutConstraint.activate([
            scanButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            scanButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -16),
            scanButton.widthAnchor.constraint(equalToConstant: ScanButtonSpacing.width),
            scanButton.heightAnchor.constraint(equalToConstant: ScanButtonSpacing.height)
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
