// 
// RegistrationViewController.swift
//  Geocaching_pmu
//
//  Created by Konstantin Kostadinov on 23.05.20

import UIKit
import Alamofire

class RegistrationViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextFIeld: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var registrationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func registrationButtonTapped(_ sender: Any) {
        let params = ["firstName" : firstNameTextField.text ?? "",
                      "lastName" : lastNameTextFIeld.text ?? "",
                      "username": usernameTextField.text ?? "",
                      "password" : passwordTextField.text ?? "",
                      "confirmPassword" : confirmPasswordTextField.text ?? ""]
        RequestManager.register(fields: params) { (user, error) in
            if let error = error {
                print("error", error)
            } else {
                let showItemStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let showItemVC = showItemStoryboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
                UserDefaultsData.isLoggedIn = true
                showItemVC.modalPresentationStyle = .fullScreen
                showItemVC.modalTransitionStyle = .crossDissolve
                UserDefaultsData.userProfile = try? user.encode()
                self.present(showItemVC, animated: true, completion: nil)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
