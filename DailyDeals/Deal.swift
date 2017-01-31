//
//  Deal.swift
//  DailyDeals
//
//  Created by practicum on 30/01/17.
//  Copyright © 2017 Jill de Ron. All rights reserved.
//

import Foundation
import MapKit
import Firebase
import FirebaseDatabase

struct Deal {
    let key: String
    let nameDeal: String
    let nameCompany: String
    let address: String
    let category: String
    let date: Double
    let uid: String
    let ref: FIRDatabaseReference?
    
    init(nameDeal: String, nameCompany: String, address: String, category: String, date: Double, uid: String,
         key: String = "") {
        self.key = key
        self.nameDeal = nameDeal
        self.nameCompany = nameCompany
        self.address = address
        self.category = category
        self.uid = uid
        self.date = date
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value! as! [String: AnyObject]
        nameDeal = snapshotValue["nameDeal"] as! String
        nameCompany = snapshotValue["nameCompany"] as! String
        address = snapshotValue["address"] as! String
        category = snapshotValue["category"] as! String
        date = snapshotValue["date"] as! Double
        uid = snapshotValue["uid"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "nameDeal" : nameDeal,
            "nameCompany" : nameCompany,
            "address" : address,
            "category" : category,
            "date" : date,
            "uid" : uid
        ]
    }
    
}
