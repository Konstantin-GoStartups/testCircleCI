import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //register()
        login()
    }
    
    func register() {
        let params = ["firstName" : "Konstantin",
                      "lastName" : "Kostadinov",
                      "username": "OGSkills",
                      "password" : "Kosio123kosio",
                      "confirmPassword" : "Kosio123kosio"]
        Alamofire.request("http://127.0.0.1:8080/backend/users/register", method: .post, parameters: params).response { response in
            print("resposne", response)
        }
    }
    
    func login() {
        let username = "OGSkills"
        let password = "Kosio123kosio"
        let loginString = "\(username):\(password)"

        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        Alamofire.request("http://127.0.0.1:8080/backend/users/login", method: .post, headers: ["Authorization": "Basic \(base64LoginString)"]).response{ json in
            print("json", String(data: json.data!, encoding:  String.Encoding.utf8))
            //print("error", error)
            
        }
    }


}

