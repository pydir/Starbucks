//
//  AppDelegate.swift
//  Starbucks
//
//  Created by Oguz Mert Beyoglu on 12.10.2024.
//

import UIKit

let appColor: UIColor = UIColor(red: 0/255, green: 102/255, blue: 51/255, alpha: 1)

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
     
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        window?.rootViewController = MainViewController()
        
        return true
    }
    
    func makeNavigationController(rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.label,
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .title1).withTraits(traits: .traitBold)
        ]
        navigationController.navigationBar.largeTitleTextAttributes = attrs
        return navigationController
    }
}

