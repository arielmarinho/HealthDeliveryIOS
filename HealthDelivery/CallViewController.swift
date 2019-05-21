//
//  CallViewController.swift
//  HealthDelivery
//
//  Created by Mac on 01/05/19.
//  Copyright © 2019 HealthDelivery. All rights reserved.
//

import UIKit

class CallViewController: UIViewController {


    @IBOutlet weak var phone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btn_call(_ sender: Any) {
        let url:NSURL = URL(string: "TEL://\(String(describing: self.phone.text))")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        
    }
    
    
 
    
}
