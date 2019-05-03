//
//  OrderModel.swift
//  HealthDelivery
//
//  Created by Mac on 01/05/19.
//  Copyright © 2019 HealthDelivery. All rights reserved.
//

class OrderModel{
    var max:String?
    var min:String?
    var name:String?
    var order_id:String?
    var phone:String?
    
    init(max:String?, min:String?, name:String, order_id:String, phone:String) {
        
        self.max = max;
        self.min = min;
        self.name = name;
        self.order_id = order_id;
        self.phone = phone;
    }
    
}
