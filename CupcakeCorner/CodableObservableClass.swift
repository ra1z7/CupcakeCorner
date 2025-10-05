//
//  CodableObservableClass.swift
//  CupcakeCorner
//
//  Created by Purnaman Rai (College) on 05/10/2025.
//

import SwiftUI

// Observable macro changes your code behind the scenes, and Codable's automatic behavior doesn't know how to handle those changes gracefully.

@Observable
class User: Codable {
    // Inside the enum you need to write one case for each property you want to save, along with a raw value containing the name you want to give it. In our case, that means saying that _name – the underlying storage for our name property – should be written out as the string "name", without an underscore.
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }
    // This coding key mapping works both ways: when Codable sees "name" in some JSON, it will automatically be saved in the _name property.
    
    var name = "Taylor"
}

struct CodableObservableClass: View {
    var body: some View {
        Button("Encode User", action: encodeUser)
    }
    
    func encodeUser() {
        let encodedUser = try! JSONEncoder().encode(User())
        let encodedUserAsString = String(decoding: encodedUser, as: UTF8.self)
        print(encodedUserAsString)
        /*
         Before implementing CodingKeys enum:
            {"_name":"Taylor","_$observationRegistrar":{}}
         
            // We can notice, our name property is now _name and there's also an observation registrar instance (which keeps a list of all the SwiftUI views that are watching this object for changes) in the JSON. If you're trying to send a "name" value to a server, it might have no idea what to do with "_name". To fix this, we need to stop relying on Codable's automatic behavior and tell Swift exactly how it should encode and decode our data. This is done by nesting an enum inside our class called CodingKeys, and making it have a String raw value and a conformance to the CodingKey protocol.
         
         After implementing CodingKeys enum:
            {"name":"Taylor"}
         */
    }
}

#Preview {
    CodableObservableClass()
}
