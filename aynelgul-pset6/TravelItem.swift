//
//  TravelItem.swift
//  aynelgul-pset6
//
//  Created by Aynel Gül on 08-12-16.
//  Copyright © 2016 Aynel Gül. All rights reserved.
//

import Foundation
import Firebase

struct TravelItem {
        
    let key: String
    let name: String

    let ref: FIRDatabaseReference?
    
    init(name: String) {
        self.key = ""
        self.name = name
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String

        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
        ]
    }
    
}
