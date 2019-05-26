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
        self.etPhone.delegate = self
        self.etValueMax.delegate = self
        self.etValueMin.delegate = self
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
        if (etName.text!.isEmpty || etPhone.text!.isEmpty || etValueMin.text!.isEmpty || etValueMax.text!.isEmpty){
            create_alert(title: "Erro", message: "Por favor preencha todos os campos")
        }
        else{
        addOrder()
        showNextScreen()
            
        }
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
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)-> Bool {
        let allowed = "+1234567890"
        let allowedCharSet = CharacterSet(charactersIn: allowed)
        let typedCharset = CharacterSet(charactersIn: string)
        return allowedCharSet.isSuperset(of: typedCharset)
    }
    func showNextScreen() {
        print("Indo para a próxima tela")
        let mainTabBarController = storyboard?.instantiateViewController(withIdentifier: "MainTabController") as! MainTabController
        mainTabBarController.selectedViewController = mainTabBarController.viewControllers?[0]
        present(mainTabBarController, animated: true,completion: nil)
    }
}
