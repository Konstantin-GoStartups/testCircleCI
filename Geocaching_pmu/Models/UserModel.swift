// 
// UserModel.swift
//  Geocaching_pmu
//
//  Created by Konstantin Kostadinov on 24.05.20

import Foundation

public class UserModel: Codable {
    public var firstName: String
    public var lastName: String
    public var username: String
    public var userId: String
    public var containersFound: [String]?
    public var areasUnlocked: [Int]?
    
    init(json: [String:Any]) {
        self.firstName = json["firstName"] as! String
        self.lastName = json["lastName"] as! String
        self.username = json["username"] as! String
        self.userId = json["userID"] as! String
        self.containersFound = json["containersFound"] as? [String] ?? []
        self.areasUnlocked = json["areasUnlocked"] as? [Int] ?? []
    }
}
