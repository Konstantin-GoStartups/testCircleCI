// 
// Container.swift
//  Geocaching_pmu
//
//  Created by Konstantin Kostadinov on 28.05.20

import Foundation

public class Container {
    public var containerId: String
    public var creator: String
    public var qrCode: Int
    public var coordinates: [String]
    public var packageSize: Double
    public var terrain: Double
    public var difficulty: Double
    public var containerDescription: String
    
    init(json: [String:Any]) {
        self.containerId = json["id"] as! String
        self.creator = json["creator"] as! String
        self.qrCode = json["qrCode"] as! Int
        self.coordinates = json["coordinates"] as? [String] ?? []
        self.packageSize = json["packageSize"] as! Double
        self.terrain = json["terrain"] as! Double
        self.difficulty = json["difficulty"] as! Double
        self.containerDescription = json["containerDescription"] as! String
    }
    
}
