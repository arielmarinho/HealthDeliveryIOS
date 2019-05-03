//
//  OrdersViewController.swift
//  HealthDelivery
//
//  Created by Mac on 01/05/19.
//  Copyright © 2019 HealthDelivery. All rights reserved.
//

import UIKit
import Firebase

class OrdersViewController: UIViewController, UITabBarDelegate,UITableViewDataSource {
    
    var refOrders:DatabaseReference!
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrdersList.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrderTableViewCell
        let order: OrderModel
        order = OrdersList[indexPath.row]
        cell.lblName.text = order.name
        cell.lblMin.text = order.min
        cell.lblMax.text = order.max
        return cell
        
    }
    
    
    @IBOutlet weak var TBLorders: UITableView!
    var OrdersList = [OrderModel]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refOrders = Database.database().reference().child("orders");
        
        refOrders.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.OrdersList.removeAll()
                for orders in snapshot.children.allObjects as![DataSnapshot]{
                    let orderObject = orders.value as? [String: AnyObject]
                    let orderMax = orderObject?["max"]
                    let orderMin = orderObject?["min"]
                    let orderName = orderObject?["name"]
                    let orderId = orderObject?["order_id"]
                    let orderPhone = orderObject?["phone"]
                    
                    
                    
                    let order = OrderModel(max: orderMax as! String, min: orderMin as! String, name: orderName as! String, order_id: orderId as! String, phone: orderPhone as! String)
                    
                    self.OrdersList.append(order)
                }
                self.TBLorders.reloadData()
            }
        })
        
    }
    
    
    @IBAction func btn_Logout(_ sender: Any) {
        
       try! Auth.auth().signOut()
        self.performSegue (withIdentifier: "login", sender: self)
        exit(0)
    }
    
/*
        let alertController = UIAlertController(title: "iOScreator", message:
            "Hello, world!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    
    */
    func deleteOrder (id :String){
        refOrders.child(id).setValue(nil)
    }
}
