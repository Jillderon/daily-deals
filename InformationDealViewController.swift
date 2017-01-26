//
//  InformationDealViewController.swift
//  
//
//  Created by practicum on 26/01/17.
//
//

import UIKit
import FirebaseDatabase

class InformationDealViewController: UIViewController {
    
    // MARK: Variables.
    var nameDealReceiver = String()
    let ref = FIRDatabase.database().reference(withPath: "activities")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func readInformation() {
        ref.child(nameDealReceiver).observe(.value, with: { (snapshot) in
            guard let snapshotDict = snapshot.value as? [String: AnyObject] else {
                return
            }
            
            let nameDeal = snapshotDict["nameDeal"]
            let nameCompany = snapshotDict["nameCompany"]
            print(nameDeal!)
            print(nameCompany!)
        })
    }

}
