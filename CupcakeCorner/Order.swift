//
//  Order.swift
//  CupcakeCorner
//
//  Created by Purnaman Rai (College) on 10/10/2025.
//

import Foundation

@Observable
class Order {
    static let allTypes = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    // var specialRequestEnabled = false // <- a bug: if we enable special requests then enable one or both of “extra frosting” and “extra sprinkles”, then disable the special requests, our previous special request selection stays active.This kind of problem isn’t hard to work around if every layer of your code is aware of it – if the app, your server, your database, and so on are all programmed to ignore the values of extraFrosting and addSprinkles when specialRequestEnabled is set to false. However, a better idea – a safer idea – is to make sure that both extraFrosting and addSprinkles are reset to false when specialRequestEnabled is set to false:
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
}
