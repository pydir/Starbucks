//
//  MainViewController.swift
//  Starbucks
//
//  Created by Oguz Mert Beyoglu on 12.10.2024.
//

import Foundation
import UIKit

class MainViewController: UITabBarController {
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTabBar()
    }
    
    private func setupViews() {
        let homeVC  = HomeViewController()
        let scanVC  = ScanViewController()
        let orderVC = OrderViewController()
        let giftVC  = GiftViewController()
        let storeVC = StoreViewController()
        
        homeVC.setTabBarImage(imageName: "house.fill", title: "Home")
        scanVC.setTabBarImage(imageName: "qrcode", title: "Scan")
        orderVC.setTabBarImage(imageName: "arrow.up.bin.fill", title: "Order")
        giftVC.setTabBarImage(imageName: "gift.fill", title: "Gift")
        storeVC.setTabBarImage(imageName: "location.fill", title: "Location")
        
        let scanNC  = UINavigationController(rootViewController: scanVC)
        let orderNC = UINavigationController(rootViewController: orderVC)
        let giftNC  = UINavigationController(rootViewController: giftVC)
        let storeNC = UINavigationController(rootViewController: storeVC)
        
        homeVC.navigationController?.navigationBar.barTintColor = appColor
        
        let tabBarList = [homeVC, scanNC, orderNC, giftNC, storeNC]
        
        viewControllers = tabBarList
        
    }
    
    private func setupTabBar() {
        tabBar.tintColor     = appColor
        tabBar.isTranslucent = false
    }
    
    private func hideNavigationBarLine(_ navigationBar: UINavigationBar) {
        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
        navigationBar.isTranslucent = false
    }
}


class ScanViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }
}

class OrderViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
}

class GiftViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
    }
}

class StoreViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
    }
}


