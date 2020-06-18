// 
// Geocaching_pmuTests.swift
//  Geocaching_pmuTests
//
//  Created by Konstantin Kostadinov on 9.06.20
//  Copyright (C) 2012-2020 by Activbody, Inc. All Rights Reserved.

//  Data contained herein is proprietary information of Activbody, Inc,
//  which shall be treated confidentially and shall not be used by anyone,
//  furnished to third parties or made public without prior written permission by Activbody, Inc.

//  The Activbody(TM), Activ5(TM) and TAO brands and products are fully protected
//  by international trademark, copyright and patent laws.
//  All rights reserved 2008-2020 Activbody, Inc.

import XCTest
@testable import Geocaching_pmu

class Geocaching_pmuTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserModel() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let json: [String:Any] = ["firstName" : "Konstantin",
                    "lastName" : "Kostadinov",
                    "username" : "OGSkills",
                    "userID" : "MyUserID123",
                    "containersFound" : ["zdr","123","opa"],
                    "areasUnlocked" : [1,2,3,4]]
        let user = UserModel(json: json)
        XCTAssertTrue(user.firstName == json["firstName"] as! String, "First name does not match")
        XCTAssertTrue(user.lastName == json["lastName"] as! String, "Last name does not match")
        XCTAssertTrue(user.username == json ["username"] as! String, "Username does not match")
        XCTAssertTrue(user.userId == json["userID"] as! String, "user id does not match")
        XCTAssertTrue(user.containersFound == json["containersFound"] as! [String]?, "containers does not match")
        XCTAssertTrue(user.areasUnlocked == json["areasUnlocked"] as! [Int]?, "areas unlocked does not match")
    }

    func testContainerModel() {
        let json: [String:Any] = ["id" : "containerId",
                    "creator" : "Kostadinov",
                    "qrCode" : 1,
                    "coordinates" : ["1.24", "1.25"],
                    "packageSize" : 1.0,
                    "terrain" : 1.0,
                    "difficulty" : 1.0,
                    "containerDescription" : "omg zdr bepcesdfsdf sdfsdfsdfdf"]
        let container = Container(json: json)
        XCTAssertTrue(container.containerId == json["id"] as! String, "container id does not match")
        XCTAssertTrue(container.creator == json["creator"] as! String, "creator does not match")
        XCTAssertTrue(container.qrCode == json ["qrCode"] as! Int, "qrCode does not match")
        XCTAssertTrue(container.coordinates == json["coordinates"] as! [String], "user id does not match")
        XCTAssertTrue(container.packageSize == json["packageSize"] as! Double, "containers does not match")
        XCTAssertTrue(container.terrain == json["terrain"] as! Double, "terrain does not match")
        XCTAssertTrue(container.difficulty == json["difficulty"] as! Double, "difficulty  does not match")
        XCTAssertTrue(container.containerDescription == json["containerDescription"] as! String, "container description does not match")


    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
