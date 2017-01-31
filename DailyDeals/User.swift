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
import FirebaseDatabase

struct User {
    
    let uid: String
    let email: String
    var type: Int?
    let ref: FIRDatabaseReference?
    let key: String

    
    init(authData: FIRUser) {
        uid = authData.uid
        email = authData.email!
        key = ""
        ref = nil
    }
    
    init(uid: String, email: String, type: Int, key: String = "") {
        self.uid = uid
        self.email = email
        self.type = type
        self.key = key
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value! as! [String: AnyObject]
        uid = snapshotValue["uid"] as! String
        email = snapshotValue["email"] as! String
        type = snapshotValue["type"] as? Int
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "uid": uid,
            "email": email,
            "type": type ?? 0
        ]
    }
    
}
