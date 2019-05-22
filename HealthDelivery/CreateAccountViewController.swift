//
//  CreateAccountViewController.swift
//  HealthDelivery
//
//  Created by Caue on 29/04/19.
//  Copyright © 2019 HealthDelivery. All rights reserved.
//

import UIKit
import Firebase


class CreateAccountViewController: UIViewController {
    @IBOutlet weak var tfLogin: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
    }
    func UserChange(user: User?){
        guard let user = user else {return}
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.commitChanges{(error) in
            if error != nil{
                print(error!)
            }
            self.showNextScreen(user: user,animated: true)
        }
    }
    
    
    @IBAction func btn_CreateAccount(_ sender: Any) {
        if tfPassword.text! == tfConfirmPassword.text!{
            print("chegou aqui")
            Auth.auth().createUser(withEmail: tfLogin.text!, password: tfPassword.text!) { (result, error) in
                if error == nil {
                    print("criou")
                     self.UserChange(user: result?.user)
                } else {
                    print(error!)
                    self.criando_alert(title: "Erro", message: "Por favor preencha todos os campos")
                    
                }
            }
        
        }
        
    }
    func showNextScreen(user: User?, animated: Bool = true) {
        print("Indo para a próxima tela depois de cadastrar")
        let mainTabBarController = storyboard?.instantiateViewController(withIdentifier: "MainTabController") as! MainTabController
        mainTabBarController.selectedViewController = mainTabBarController.viewControllers?[2]
        present(mainTabBarController, animated: true,completion: nil)
    }
    func criando_alert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
