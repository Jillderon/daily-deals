//
//  AddDealViewController.swift
//  DailyDeals
//
//  Created by practicum on 12/01/17.
//  Copyright © 2017 Jill de Ron. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AddDealViewController: UIViewController {
    
    @IBOutlet weak var textfieldNameDeal: UITextField!
    @IBOutlet weak var textfieldNameCompany: UITextField!
    
    let reference = FIRDatabase.database().reference(withPath: "activities")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func AddDeal(_ sender: Any) {
        guard textfieldNameDeal.text != "" && textfieldNameCompany.text != "" else {
            return
        }
        
        let activity = Activity(nameDeal: textfieldNameDeal.text!, nameCompany: textfieldNameCompany.text!)
        let activityRef = self.reference.child(self.textfieldNameDeal.text!.lowercased())
        activityRef.setValue(activity.toAnyObject())
    }
    

}
