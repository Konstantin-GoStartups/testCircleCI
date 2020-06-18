// 
// LoginViewController.swift
//  Geocaching_pmu
//
//  Created by Konstantin Kostadinov on 23.05.20

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextFIeld: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginButtonTapped(_ sender: Any) {
//        SVProgressHUD.show()
        let username = emailTextField.text ?? ""
        let password = passwordTextFIeld.text ?? ""
        if (emailTextField.text?.isEmpty == true) || ((passwordTextFIeld.text?.isEmpty) == true) {
//            SVProgressHUD.showError(withStatus: "Има празни полета")
        }
        RequestManager.login(username: username, password: password) { (user, error) in
            if let error = error {
                print(error)
            }
            else {
                let showItemStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let showItemVC = showItemStoryboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
                showItemVC.modalPresentationStyle = .fullScreen
                showItemVC.modalTransitionStyle = .crossDissolve
                UserDefaultsData.isLoggedIn = true
                UserDefaultsData.userProfile = try? user.encode()
//                SVProgressHUD.dismiss()
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
