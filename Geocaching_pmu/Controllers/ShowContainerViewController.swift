// 
// ShowContainerViewController.swift
//  Geocaching_pmu
//
//  Created by Konstantin Kostadinov on 4.06.20
//  Copyright (C) 2012-2020 by Activbody, Inc. All Rights Reserved.

//  Data contained herein is proprietary information of Activbody, Inc,
//  which shall be treated confidentially and shall not be used by anyone,
//  furnished to third parties or made public without prior written permission by Activbody, Inc.

//  The Activbody(TM), Activ5(TM) and TAO brands and products are fully protected
//  by international trademark, copyright and patent laws.
//  All rights reserved 2008-2020 Activbody, Inc.

import UIKit
import SVProgressHUD

class ShowContainerViewController: UIViewController {
    @IBOutlet weak var lattitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var terrainLabel: UILabel!
    @IBOutlet weak var packageSizeLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    var container: Container?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    
    private func setupView() {
        guard let container = container else { return }
        lattitudeLabel.text = container.coordinates.first
        longitudeLabel.text = container.coordinates.last
        terrainLabel.text = "\(container.terrain ?? 0)"
        packageSizeLabel.text = "\(container.packageSize ?? 0)"
        difficultyLabel.text = "\(container.difficulty ?? 0)"
        
        if container.creator == UserDefaultsData.userUUID {
            actionButton.setTitle("Ваш контейнер", for: .normal)
            actionButton.isEnabled = false
        }
    }
    
    @IBAction func actionButtonTapped(_ sender: Any) {
        SVProgressHUD.show()
        if UserDefaultsData.latitude != (container?.coordinates.first as! NSString).doubleValue || UserDefaultsData.longitude != (container?.coordinates.last as! NSString).doubleValue {
            SVProgressHUD.showError(withStatus: "НЕ сте на мястото")
        }
        let dict = ["userID" : UserDefaultsData.userUUID,
                    "containerID" : container?.containerId]
        RequestManager.addContainerToUser(dict: dict) { (user, error) in
            if let error = error {
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            } else {
                UserDefaultsData.userProfile = try? user.encode()
                SVProgressHUD.dismiss()
            }
        }
    }
    


}
