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
    let category: String
    let date: Double
    let uid: String
    let longitude: Double
    let latitude: Double
    let ref: FIRDatabaseReference?
    
    init(nameDeal: String, nameCompany: String, longitude: Double, latitude: Double, category: String, date: Double, uid: String,
         key: String = "") {
        self.key = key
        self.nameDeal = nameDeal
        self.nameCompany = nameCompany
        self.category = category
        self.uid = uid
        self.longitude = longitude
        self.latitude = latitude
        self.date = date
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value! as! [String: AnyObject]
        nameDeal = snapshotValue["nameDeal"] as! String
        nameCompany = snapshotValue["nameCompany"] as! String
        category = snapshotValue["category"] as! String
        date = snapshotValue["date"] as! Double
        uid = snapshotValue["uid"] as! String
        longitude = snapshotValue["longitude"] as! Double
        latitude = snapshotValue["latitude"] as! Double
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "nameDeal" : nameDeal,
            "nameCompany" : nameCompany,
            "category" : category,
            "date" : date,
            "longitude" : longitude,
            "latitude" : latitude,
            "uid" : uid
        ]
    }
    
}

