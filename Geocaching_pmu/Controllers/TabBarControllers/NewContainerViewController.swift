// 
// NewContainerViewController.swift
//  Geocaching_pmu
//
//  Created by Konstantin Kostadinov on 2.06.20
//  Copyright (C) 2012-2020 by Activbody, Inc. All Rights Reserved.

//  Data contained herein is proprietary information of Activbody, Inc,
//  which shall be treated confidentially and shall not be used by anyone,
//  furnished to third parties or made public without prior written permission by Activbody, Inc.

//  The Activbody(TM), Activ5(TM) and TAO brands and products are fully protected
//  by international trademark, copyright and patent laws.
//  All rights reserved 2008-2020 Activbody, Inc.

import UIKit
import SVProgressHUD
import CoreLocation
import iOSDropDown

class NewContainerViewController: UIViewController {
    @IBOutlet weak var coordinatesLabel: UILabel!
    @IBOutlet weak var latitudeTextView: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var areaTextField: DropDown!
    @IBOutlet weak var packageSizeLabel: UILabel!
    @IBOutlet weak var packageSizeTextField: DropDown!
    @IBOutlet weak var terrainLabel: UILabel!
    @IBOutlet weak var terrainTextField: DropDown!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var difficultyTextField: DropDown!
    @IBOutlet weak var containerDescriptionLabel: UILabel!
    @IBOutlet weak var containerDescriptionTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    private let optionsArray = ["1","2","3","4","5"]
    private let ids = [0,1,2,3,4]
    override func viewDidLoad() {
        super.viewDidLoad()
        longitudeTextField.isUserInteractionEnabled = false
        latitudeTextView.isUserInteractionEnabled = false
        setupDropDowns()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        latitudeTextView.text = "\(UserDefaultsData.latitude ?? 0)"
        longitudeTextField.text = "\(UserDefaultsData.longitude ?? 0)"
        checkLocationServices()
    }
    private func checkLocationServices() {
        if !CLLocationManager.locationServicesEnabled() {
            SVProgressHUD.showError(withStatus: "Трябва да си пуснете локацията")
            sendButton.isEnabled = false
        }
    }
    
    private func setupDropDowns() {
        packageSizeTextField.optionArray = optionsArray
        packageSizeTextField.optionIds = ids
        terrainTextField.optionArray = optionsArray
        terrainTextField.optionIds = ids
        difficultyTextField.optionArray = optionsArray
        difficultyTextField.optionIds = ids
        
        packageSizeTextField.didSelect { (selectedText, index, id) in
            self.packageSizeTextField.text = selectedText
        }
        
        terrainTextField.didSelect { (selectedText, index, id) in
            self.terrainTextField.text = selectedText
        }
        
        difficultyTextField.didSelect { (selectedText, index, id) in
            self.difficultyTextField.text = selectedText
        }
        
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        SVProgressHUD.show()
        guard areaTextField.text != "" || packageSizeTextField.text != "" || terrainTextField.text != "" || difficultyTextField.text != "", containerDescriptionTextView.text != "" else {
            SVProgressHUD.showError(withStatus: "Попълнете всички полета")
            return
        }
        let fields: [String:Any] = ["creator" : UserDefaultsData.userUUID ?? 0,
                                    "qrCode" : Int(areaTextField.text!),
                                    "coordinates" : [latitudeTextView.text as! NSString,longitudeTextField.text],
                                    "packageSize" : (packageSizeTextField.text as! NSString).doubleValue,
                                    "terrain" : (terrainTextField.text as! NSString).doubleValue,
                                    "difficulty" : (difficultyTextField.text as! NSString).doubleValue,
                                    "containerDescription" : containerDescriptionTextView.text]
        
        RequestManager.sendContainer(container: fields) { (user,error) -> Void in
            print(error)
            SVProgressHUD.dismiss()
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
