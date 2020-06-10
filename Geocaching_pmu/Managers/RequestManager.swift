// 
// RequestManager.swift
//  Geocaching_pmu
//
//  Created by Konstantin Kostadinov on 24.05.20

import Foundation
import Alamofire

enum AuthError:String, Error {
    case invalidRequest = "Invalid request data"
    case invalidResponse = "Invalid response from server"
    case incorrectCredentials = "Wrong email and/or password"
    case accessDenied = "Access denied"
    case googleAuthError    = "Google ID not found"
    case facebookAuthError  = "Facebook ID not found"
    case invalidEmail = "Invalid email"
    case ok = "ok"
}

class RequestManager: NSObject {
    
    static let baseURL: String = "http://127.0.0.1:8080/backend/"
    
    class func login(username: String, password: String, completion: @escaping(_ user: UserModel?,_ error: Error?) -> Void) {
         let loginString = "\(username):\(password)"

         guard let loginData = loginString.data(using: String.Encoding.utf8) else {
             return
         }
         let base64LoginString = loginData.base64EncodedString()
         Alamofire.request("\(baseURL)users/login", method: .post, headers: ["Authorization": "Basic \(base64LoginString)"]).response{ response in
            
            guard response.response?.statusCode != 401 && response.response?.statusCode != 400 else {
                completion(nil, AuthError.incorrectCredentials)
                return
            }
            do {
                print("json", String(data: response.data!, encoding:  String.Encoding.utf8))
                let data = try JSONSerialization.jsonObject(with: response.data!, options: .mutableLeaves) as? [String:Any]
                guard let jsonData = data?["data"] as? [String:Any] else {
                    completion(nil, AuthError.invalidResponse)
                    return
                }
                print(jsonData["user"])
                guard let jsonUser = jsonData["user"] as? [String:Any] else {
                    completion(nil, AuthError.invalidResponse)
                    return
                }
                let user = UserModel(json: jsonUser)
                UserDefaultsData.userUUID = jsonUser["userID"] as? String ?? ""
                UserDefaultsData.authToken = jsonData["accessToken"] as? String ?? ""
                completion(user,nil)
            }catch{}
        }
    }
    
    class func register(fields: [String:Any], completion: @escaping(_ user: UserModel?,_ error: Error?) -> Void) {
        Alamofire.request("\(baseURL)users/register", method: .post, parameters: fields).response {
            response in
            guard response.response?.statusCode != 401 && response.response?.statusCode != 400 else {
                completion(nil, AuthError.incorrectCredentials)
                return
            }
            do {
                print("json", String(data: response.data!, encoding:  String.Encoding.utf8))
                let data = try JSONSerialization.jsonObject(with: response.data!, options: .mutableLeaves) as? [String:Any]
                guard let jsonData = data?["data"] as? [String:Any] else {
                    completion(nil, AuthError.invalidResponse)
                    return
                }
                print(jsonData["user"])
                guard let jsonUser = jsonData["user"] as? [String:Any] else {
                    completion(nil, AuthError.invalidResponse)
                    return
                }
                let user = UserModel(json: jsonUser)
                UserDefaultsData.userUUID = jsonUser["userID"] as? String ?? ""
                UserDefaultsData.authToken = jsonData["accessToken"] as? String ?? ""
                completion(user,nil)
            }catch{}
        }
    }
    
    class func takeAllContainers(completion: @escaping(_ containers: [Container?], _ error: Error?) -> Void){
        let header = ["Authorization" : "Bearer \(UserDefaultsData.authToken ?? "")"]
        Alamofire.request("\(baseURL)containers/sendAll", method: .get, headers: header).response { response in
            
            guard response.response?.statusCode != 401 && response.response?.statusCode != 400 else {
                completion([nil], AuthError.incorrectCredentials)
                return
            }
            var containers = [Container]()
            print("json", String(data: response.data!, encoding:  String.Encoding.utf8))
            
            do {
                let data = try JSONSerialization.jsonObject(with: response.data!, options: .mutableLeaves) as? [String:Any]
                let allData = data!["data"] as! NSArray
                for container in allData {
                    print("container", container as! [String:Any])
                    let containerObject = Container(json: container as! [String:Any])
                    containers.append(containerObject)
                }
                
                completion(containers,nil)
                
            } catch {}
            
        }
    }
    
    class func sendContainer(container: [String:Any], completion: @escaping(_ user: UserModel?,_ error: Error?)->Void?) {
        let header = ["Authorization" : "Bearer \(UserDefaultsData.authToken ?? "")"]
        Alamofire.request("\(baseURL)containers/addContainer", method: .post, parameters: container, headers: header).response { response in
            guard response.response?.statusCode != 401 && response.response?.statusCode != 400 else {
                completion(nil,AuthError.incorrectCredentials)
                return
            }
            do {
                let data = try JSONSerialization.jsonObject(with: response.data!, options: .mutableLeaves) as? [String:Any]
                guard let jsonData = data?["data"] as? [String:Any] else {
                    completion(nil, AuthError.invalidResponse)
                    return
                }
                guard let jsonUser = jsonData["user"] as? [String:Any] else {
                    completion(nil, AuthError.invalidResponse)
                    return
                }
                let user = UserModel(json: jsonUser)
                UserDefaultsData.userUUID = jsonUser["userID"] as? String ?? ""
                completion(user,nil)
            }catch{}
        }
    }
    
    class func takeContainersForAreas(areas: [String: Any], completion: @escaping(_ containers: [Container?],_ error: Error?)->Void) {
        let header = ["Authorization" : "Bearer \(UserDefaultsData.authToken ?? "")"]
        Alamofire.request("\(baseURL)containers/takeAreaContainers", method: .post, parameters: areas, headers: header).response { response in
            guard response.response?.statusCode != 401 && response.response?.statusCode != 400 else {
                completion([],AuthError.incorrectCredentials)
                return
            }
            var containers = [Container]()
            do {
                let data = try JSONSerialization.jsonObject(with: response.data!, options: .mutableLeaves) as? [String:Any]
                print("json", String(data: response.data!, encoding:  String.Encoding.utf8))
                print("AllData", data!["data"])
                   let allData = data!["data"] as! NSArray
                    for container in allData {
                        print("container", container as! [String:Any])
                        let containerObject = Container(json: container as! [String:Any])
                        containers.append(containerObject)
                    }
                completion(containers,nil)
            }catch{}
        }
    }
    class func unloackArea(area: Int, completion: @escaping( _ user: UserModel?,_ error:Error?)->Void){
        let header = ["Authorization" : "Bearer \(UserDefaultsData.authToken ?? "")"]
        let areaDic = ["area" : area]
        Alamofire.request("\(baseURL)users/addArea", method: .post, parameters: areaDic, headers: header).response { response in
            guard response.response?.statusCode != 401 && response.response?.statusCode != 400 else {
                completion(nil,AuthError.incorrectCredentials)
                return
            }
            do {
                let data = try JSONSerialization.jsonObject(with: response.data!, options: .mutableLeaves) as? [String:Any]
                guard let jsonData = data?["data"] as? [String:Any] else {
                    completion(nil, AuthError.invalidResponse)
                    return
                }
                guard let jsonUser = jsonData["user"] as? [String:Any] else {
                    completion(nil, AuthError.invalidResponse)
                    return
                }
                let user = UserModel(json: jsonUser)
                UserDefaultsData.userUUID = jsonUser["userID"] as? String ?? ""
                completion(user,nil)
            }catch{}
        }
    }
    
    class func addContainerToUser(dict: [String:Any], completion: @escaping(_ user:UserModel?, _ error: Error?)->Void) {
        let header = ["Authorization" : "Bearer \(UserDefaultsData.authToken ?? "")"]
        Alamofire.request("\(baseURL)containers/addToUser", method: .post, parameters: dict, headers: header).response { response in
            guard response.response?.statusCode != 401 && response.response?.statusCode != 400 else {
                completion(nil,AuthError.incorrectCredentials)
                return
            }
            do {
                let data = try JSONSerialization.jsonObject(with: response.data!, options: .mutableLeaves) as? [String:Any]
                guard let jsonData = data?["data"] as? [String:Any] else {
                    completion(nil, AuthError.invalidResponse)
                    return
                }
                guard let jsonUser = jsonData["user"] as? [String:Any] else {
                completion(nil, AuthError.invalidResponse)
                return
                }
                let user = UserModel(json: jsonUser)
                UserDefaultsData.userUUID = jsonUser["userID"] as? String ?? ""
                completion(user,nil)
            }catch{}
        }
    }
}
