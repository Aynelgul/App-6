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
    let addedByUser: String
    let ref: FIRDatabaseReference?
    
    init(name: String, addedByUser: String, key: String = "") {
        self.key = key
        self.name = name
        self.addedByUser = addedByUser
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        addedByUser = snapshotValue["addedByUser"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "addedByUser": addedByUser,
        ]
    }
    
}
