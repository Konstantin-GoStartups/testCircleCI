// 
// LoadingLogicViewController.swift
//  Geocaching_pmu
//
//  Created by Konstantin Kostadinov on 23.05.20

import UIKit

class LoadingLogicViewController: UIViewController {
    
    private enum Constants {
        static let navController = "NavController"
        static let tabBarController = "MainTabBarController"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        checkIfLoggedIn()
    }
    
    private func checkIfLoggedIn() {
        if !UserDefaultsData.isLoggedIn {
            let showItemStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let showItemVC = showItemStoryboard.instantiateViewController(withIdentifier: Constants.navController) as! UINavigationController
            showItemVC.modalPresentationStyle = .fullScreen
            showItemVC.modalTransitionStyle = .crossDissolve
            self.present(showItemVC, animated: true, completion: nil)
        } else {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let firstVC = storyBoard.instantiateViewController(withIdentifier: Constants.tabBarController) as! UITabBarController
            firstVC.modalPresentationStyle = .fullScreen
            firstVC.modalTransitionStyle = .crossDissolve
            self.present(firstVC, animated: true, completion: nil)


        }
    }
}
