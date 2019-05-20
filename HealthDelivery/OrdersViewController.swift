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
        cell.lblMin.text = "\(order.min!)"
        cell.lblMax.text = "\(order.max!)"
        return cell
        
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        //performSegue(withIdentifier: "EditViewController", sender: self)
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let order = OrdersList[indexPath.row]
        deleteOrder(id: order.order_id!)
        
    }
    @IBOutlet weak var TBLorders: UITableView!
    var OrdersList = [OrderModel]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refOrders = Database.database().reference().child("orders");
        
        refOrders.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>=0{
                self.OrdersList.removeAll()
                for orders in snapshot.children.allObjects as![DataSnapshot]{
                    let orderObject = orders.value as? [String: AnyObject]
                    let orderMax = orderObject?["max"]
                    let orderMin = orderObject?["min"]
                    let orderName = orderObject?["name"]
                    let orderId = orderObject?["order_id"]
                    let orderPhone = orderObject?["phone"]
                    
                    
                    
                    let order = OrderModel(max: orderMax as! Double, min: orderMin as! Double, name: orderName as! String, order_id: orderId as! String, phone: orderPhone as! String)
                    
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
    
    func deleteOrder (id :String){
        refOrders.child(id).setValue(nil)
    }
    @IBAction func btnCall(_ sender: Any) {
        performSegue(withIdentifier: "call", sender: self)
    }
    
}
