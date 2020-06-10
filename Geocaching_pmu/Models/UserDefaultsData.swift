// 
// UserDefaultData.swift
//  Geocaching_pmu
//
//  Created by Konstantin Kostadinov on 23.05.20

import Foundation

final class UserDefaultsData {
    static var isLoggedIn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: GlobalConstants.UserDefaultsKeys.isLoggedIn)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: GlobalConstants.UserDefaultsKeys.isLoggedIn)
            UserDefaults.standard.synchronize()
        }
    }
    static var userUUID: String? {
        get {
            return UserDefaults.standard.string(forKey: GlobalConstants.UserDefaultsKeys.userUUID)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: GlobalConstants.UserDefaultsKeys.userUUID)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var authToken: String? {
        get {
            return UserDefaults.standard.string(forKey: GlobalConstants.UserDefaultsKeys.authToken)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: GlobalConstants.UserDefaultsKeys.authToken)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var areasUnlocked: [Int?] {
        get {
            return UserDefaults.standard.stringArray(forKey: GlobalConstants.UserDefaultsKeys.areasUnlocked) as! [Int?]
        }
        set {
            UserDefaults.standard.set(newValue, forKey:  GlobalConstants.UserDefaultsKeys.areasUnlocked)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var containersFound: [String?] {
        get {
            return UserDefaults.standard.stringArray(forKey: GlobalConstants.UserDefaultsKeys.containersFound) ?? [""]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: GlobalConstants.UserDefaultsKeys.containersFound)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var userProfile: Data? {
        get {
            return UserDefaults.standard.data(forKey: GlobalConstants.UserDefaultsKeys.usersProfile)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: GlobalConstants.UserDefaultsKeys.usersProfile)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var longitude: Double? {
        get {
            return UserDefaults.standard.double(forKey: GlobalConstants.UserDefaultsKeys.longitude)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: GlobalConstants.UserDefaultsKeys.longitude)
            UserDefaults.standard.synchronize()
        }
    }
    
    static var latitude: Double? {
        get {
            return UserDefaults.standard.double(forKey: GlobalConstants.UserDefaultsKeys.latitude)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: GlobalConstants.UserDefaultsKeys.latitude)
            UserDefaults.standard.synchronize()
        }
    }
}
