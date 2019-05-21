//
//  RegisterOrderViewController.swift
//  HealthDelivery
//
//  Created by Caue on 29/04/19.
//  Copyright © 2019 HealthDelivery. All rights reserved.
//

import UIKit
import Firebase

class RegisterOrderViewController: UIViewController, UITextFieldDelegate {
    
    var refOrders: DatabaseReference!
    
    @IBOutlet weak var etValueMin: UITextField!
    @IBOutlet weak var etPhone: UITextField!
    @IBOutlet weak var etName: UITextField!
    @IBOutlet weak var etValueMax: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.etValueMax.delegate = self
        self.etValueMin.delegate = self
        self.etName.delegate = self
        self.etPhone.delegate = self
        refOrders = Database.database().reference().child("orders");
    }
    func addOrder(){
        let key = refOrders.childByAutoId().key
        let order = ["order_id" :key,
                     "name": etName.text! as String,
                     "phone": etPhone.text! as String,
                     "min": Double(etValueMin.text!),
                     "max": Double(etValueMax.text!)
            ] as [String : Any]
        refOrders.child(key!).setValue(order)
    }
    
    @IBAction func RegisterOrder(_ sender: Any) {
        addOrder()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return(true)
        
    }
    func create_alert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        create_alert(title: "Sucesso", message: "funcionou")
    }
}
