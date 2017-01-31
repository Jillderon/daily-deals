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
    
    // MARK: Outlets.
    @IBOutlet weak var textfieldNameDeal: UITextField!
    @IBOutlet weak var textfieldNameCompany: UITextField!
    @IBOutlet weak var textfieldAddress: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!

    // MARK: Variables.
    let deals = ["Shopping", "Food", "Hotels", "Activities", "Party", "Other"]
    let reference = FIRDatabase.database().reference(withPath: "deals")
    var PlacementAnswer = 0
    var interval = Double()
    var dateDeal = NSDate()
    
    
    // MARK: Standard functions.
    override func viewDidLoad() {
        super.viewDidLoad()
        informationPickers()
        hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: PickerView functionality.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let str = deals[row]
        return NSAttributedString(string: str, attributes: [NSForegroundColorAttributeName:UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return deals.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        PlacementAnswer = row
    }
    
    func informationPickers() {
        pickerView.delegate = self
        pickerView.dataSource = self
        datePicker.setValue(UIColor.white, forKey: "textColor")
    }
    
    // MARK: Alert functions. 
    func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title , message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func alertAdressFormat() {
        let alertController = UIAlertController(title: "The address must be formatted as streetname + number", message: "Is " + textfieldAddress.text! + " formatted this way? If not the deal won't be shown on the map", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "No, change Adress", style: UIAlertActionStyle.default,handler: nil))
        alertController.addAction(UIAlertAction(title: "Yes it is", style: UIAlertActionStyle.default)
        { action -> Void in
            self.performSegue(withIdentifier: "toMapAgain", sender: self)
        })
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Actions.
    @IBAction func AddDeal(_ sender: Any) {
        guard textfieldNameDeal.text != "" && textfieldNameCompany.text != "" && textfieldAddress.text != "" else {
            self.alert(title: "Error with adding deal", message: "Enter the title of the deal and the name and address of the company")
            return
        }

        alertAdressFormat()
        
        dateDeal = datePicker.date as NSDate
        interval = dateDeal.timeIntervalSince1970
        let deal = Deal(nameDeal: textfieldNameDeal.text!, nameCompany: textfieldNameCompany.text!, address: textfieldAddress.text!, category: deals[PlacementAnswer], date: interval)
        let dealRef = self.reference.child(self.textfieldNameDeal.text!.lowercased())
        dealRef.setValue(deal.toAnyObject())
    }
}
