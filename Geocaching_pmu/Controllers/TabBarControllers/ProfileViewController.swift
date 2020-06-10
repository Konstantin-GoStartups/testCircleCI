// 
// ProfileViewController.swift
//  Geocaching_pmu
//
//  Created by Konstantin Kostadinov on 2.06.20


import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var containersFoundLabel: UILabel!
    @IBOutlet weak var areasFoundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    private func setupView() {
        guard let userProfile = UserDefaultsData.userProfile else { return }
        if let tempUser = try? UserModel.decode(from: userProfile) {
            usernameLabel.text = tempUser.username
            nameLabel.text = tempUser.firstName
            lastNameLabel.text = tempUser.lastName
            containersFoundLabel.text = "\(tempUser.containersFound?.count ?? 0)"
            areasFoundLabel.text = "\(tempUser.areasUnlocked?.count ?? 0)"
        }
    }
    
    private func removeDataFromUserDefaults() {
        UserDefaultsData.isLoggedIn = false
        UserDefaultsData.authToken = nil
        UserDefaultsData.userUUID = nil
        UserDefaultsData.userProfile = nil
    }
    
    private func sendToLoginVC() {
        let showItemStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let showItemVC = showItemStoryboard.instantiateViewController(withIdentifier: "NavController") as! UINavigationController
        showItemVC.modalPresentationStyle = .fullScreen
        showItemVC.modalTransitionStyle = .crossDissolve
        self.present(showItemVC, animated: true, completion: nil)
    }

    @IBAction func logOutButtonTapped(_ sender: Any) {
        removeDataFromUserDefaults()
        sendToLoginVC()
    }
    
    
    
}
