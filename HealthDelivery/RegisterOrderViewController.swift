//
//  RegisterOrderViewController.swift
//  HealthDelivery
//
//  Created by Caue on 29/04/19.
//  Copyright © 2019 HealthDelivery. All rights reserved.
//

import UIKit
import Firebase

class RegisterOrderViewController: UIViewController {
    
    var refOrders: DatabaseReference!
    
    @IBOutlet weak var etValueMin: UITextField!
    @IBOutlet weak var etPhone: UITextField!
    @IBOutlet weak var etName: UITextField!
    @IBOutlet weak var etValueMax: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refOrders = Database.database().reference().child("orders");
        // Do any additional setup after loading the view.
    }
    func addOrder(){
        let key = refOrders.childByAutoId().key
        let order = ["order_id" :key,
                     "name": etName.text! as String,
                     "phone": etPhone.text! as String,
                     "min": etValueMin.text! as String,
                     "max":etValueMax.text! as String
                    ]
        refOrders.child(key!).setValue(order)
    }
    
    @IBAction func RegisterOrder(_ sender: Any) {
        addOrder()
    }
    
}
