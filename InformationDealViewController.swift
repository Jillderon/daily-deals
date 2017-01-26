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
        readInformation()
        print(nameDealReceiver)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func readInformation() {
        
    }

}
