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
import FirebaseAuth
import CoreLocation

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
    var longitude = Double()
    var latitude = Double()
    
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
        geocodeAddress()
        
    }
    
    func geocodeAddress() {
        // Create address string
        let location = "Netherlands, Amsterdam," + textfieldAddress.text!
        var coordinate = CLLocationCoordinate2D()
        
        // Geocode Address String
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                print("Unable to Forward Geocode Address (\(error))")
            } else {
                var locationPin: CLLocation?
                if let placemarks = placemarks, placemarks.count > 0 {
                    locationPin = placemarks.first?.location
                }
                
                if let locationPin = locationPin {
                    coordinate = locationPin.coordinate
                    print("coordinate")
                    print(coordinate)
                    self.latitude = coordinate.latitude
                    self.longitude = coordinate.longitude
                    
                    self.addDealInFirebase()
                }
            }
        }
    }
    
    func addDealInFirebase() {
        // Make sure valid until date is a Double (because Firebase can't save a NSDATE)
        dateDeal = datePicker.date as NSDate
        interval = dateDeal.timeIntervalSince1970
        
        // Place Deal in Firebase
        let deal = Deal(nameDeal: self.textfieldNameDeal.text!, nameCompany: self.textfieldNameCompany.text!, longitude: self.longitude, latitude: self.latitude, category: self.deals[self.PlacementAnswer], date: self.interval, uid: (FIRAuth.auth()?.currentUser?.uid)!)
        let dealRef = self.reference.child(self.textfieldNameDeal.text!.lowercased())
        dealRef.setValue(deal.toAnyObject())
    }
}

