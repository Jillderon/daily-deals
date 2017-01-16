//
//  User.swift
//  DailyDeals
//
//  Created by practicum on 13/01/17.
//  Copyright © 2017 Jill de Ron. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

struct User {
    
    let uid: String
    let email: String
    let type: String
    
    init(authData: FIRUser) {
        uid = authData.uid
        email = authData.email!
    }
    
    init(uid: String, email: String, type: String) {
        self.uid = uid
        self.email = email
        self.type = type
    }
    
    func toAnyObject() -> Any {
        return [
            "uid": uid,
            "email": email,
            "type": type 
        ]
    }
    
}
