//
//  ViewController.swift
//  HealthDelivery
//
//  Created by Ariel on 28/04/2019.
//  Copyright © 2019 HealthDelivery. All rights reserved.
//

import UIKit
import Firebase




class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var etEmail: UITextField!
    @IBOutlet weak var etPassword: UITextField!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        etEmail.delegate = self
        etPassword.delegate = self
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            print("Usuário logadou:", user?.email)
            if let user = user {
                self.showNextScreen(user: user, animated: false)
            }
        })
        
        
    }
    
    func rmlistener(){
        if let handle = handle{
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    //implementando o para return tirar o teclado
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func showNextScreen(user: User?, animated: Bool = true) {
        print("Indo para a próxima tela")
        let mainTabBarController = storyboard?.instantiateViewController(withIdentifier: "MainTabController") as! MainTabController
        mainTabBarController.selectedViewController = mainTabBarController.viewControllers?[2]
        present(mainTabBarController, animated: true,completion: nil)
            }
    
    func performUserChange(user: User?) {
        guard let user = user else {return}
        let changeRequest = user.createProfileChangeRequest()
        
        changeRequest.commitChanges { (error) in
            if error != nil {
                print(error!)
            }
            self.showNextScreen(user: user, animated: true)
        }
    }
    
    
    
    
    @IBAction func btnSignIn(_ sender: Any) {
        rmlistener()
        Auth.auth().signIn(withEmail: etEmail.text!, password: etPassword.text!) {
            (result, error) in
            if error == nil {
                self.performUserChange(user: result?.user)
            } else {
                print(error!)
            }
        }
    }
    
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}

