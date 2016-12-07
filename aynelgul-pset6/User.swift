//
//  User.swift
//  aynelgul-pset6
//
//  Created by Aynel Gül on 08-12-16.
//  Copyright © 2016 Aynel Gül. All rights reserved.
//

import Foundation
import Firebase

struct User {
    
    let uid: String
    let email: String
    
    init(authData: FIRUser) {
        uid = authData.uid
        email = authData.email!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    
}
