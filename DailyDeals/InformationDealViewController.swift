//
//  InformationDealViewController.swift
//  DailyDeals
//  
//  Description:
//  The user will see this view when clicked on a pin annotation or when clicked 
//  on a deal in the my deals tableView. Only the name of the deal and the name of the company is displayed.
//
//  Created by practicum on 26/01/17.
//

import UIKit
import FirebaseDatabase

class InformationDealViewController: UIViewController {
    
    // MARK: Outlets.
    @IBOutlet weak var nameDeal: UILabel!
    @IBOutlet weak var nameCompany: UILabel!
    
    // MARK: Variables.
    var nameDealReceiver = String()
    var nameCompanyReceiver = String()
    let ref = FIRDatabase.database().reference(withPath: "deals")
    
    // MARK: Standard functions.
    override func viewDidLoad() {
        super.viewDidLoad()
        displayInformation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Function to display information about deal.
    private func displayInformation() {
        nameDeal.text = nameDealReceiver
        nameCompany.text = nameCompanyReceiver
    }
}
