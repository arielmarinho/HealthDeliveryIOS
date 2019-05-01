//
//  OrdersViewController.swift
//  HealthDelivery
//
//  Created by Mac on 01/05/19.
//  Copyright © 2019 HealthDelivery. All rights reserved.
//

import UIKit
import Firebase

class OrdersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func btn_Logout(_ sender: Any) {
       try! Auth.auth().signOut()
        dismiss(animated: true, completion: nil)
    }
    

}
