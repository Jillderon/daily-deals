//
//  InformationDealViewController.swift
//  DailyDeals
//
//  Created by practicum on 26/01/17.
//  Copyright © 2017 Jill de Ron. All rights reserved.
//

import UIKit
import FirebaseDatabase

class InformationDealViewController: UIViewController {
    
    // MARK: Variables.
//    var nameDealReceiver = String()
    let ref = FIRDatabase.database().reference(withPath: "activities")
    
    // MARK: Outlets.


    // MARK: Functions.
    override func viewDidLoad() {
        super.viewDidLoad()
//        readInformation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    func readInformation() {
//        ref.child(nameDealReceiver).observe(.value, with: { (snapshot) in
//            guard let snapshotDict = snapshot.value as? [String: AnyObject] else {
//                return
//            }
//            
//            let nameDeal = snapshotDict["nameDeal"]
//            let nameCompany = snapshotDict["nameCompany"]
//            print(nameDeal!)
//            print(nameCompany!)
//            
//        })
//        
//
//    }

}
