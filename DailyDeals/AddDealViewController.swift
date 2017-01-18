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

class AddDealViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var textfieldNameDeal: UITextField!
    @IBOutlet weak var textfieldNameCompany: UITextField!
    @IBOutlet weak var textfieldAddress: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var pickerDate: UIDatePicker!
    
    let activities = ["Shopping", "Food", "Hotels", "Activities", "Festivals", "Party", "Other"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activities.count
    }
    
    let reference = FIRDatabase.database().reference(withPath: "activities")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func AddDeal(_ sender: Any) {
        guard textfieldNameDeal.text != "" && textfieldNameCompany.text != "" && textfieldAddress.text != "" else {
            self.alert(title: "Error with adding deal", message: "Enter the title of the deal and the name and address of the company")
            return
        }
        
        let activity = Activity(nameDeal: textfieldNameDeal.text!, nameCompany: textfieldNameCompany.text!, address: textfieldAddress.text!)
        let activityRef = self.reference.child(self.textfieldNameDeal.text!.lowercased())
        activityRef.setValue(activity.toAnyObject())
        self.performSegue(withIdentifier: "toMapAgain", sender: self)
    }
    
    func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title , message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }

}
