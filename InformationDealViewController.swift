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
    var nameCompanyReceiver = String()
    let ref = FIRDatabase.database().reference(withPath: "deals")
    
    // MARK: Outlets.
    @IBOutlet weak var nameDeal: UILabel!
    @IBOutlet weak var nameCompany: UILabel!
    
    // MARK: Standard functions.
    override func viewDidLoad() {
        super.viewDidLoad()
        displayInformation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayInformation() {
        nameDeal.text = nameDealReceiver
        nameCompany.text = nameCompanyReceiver
    }
}
