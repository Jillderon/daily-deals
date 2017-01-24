//
//  SearchDealViewController.swift
//  DailyDeals
//
//  Created by practicum on 12/01/17.
//  Copyright © 2017 Jill de Ron. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SearchDealViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    // MARK: Outlets.
    @IBOutlet weak var pickerView: UIPickerView!
    
    // MARK: Variables. 
    let activitiesCategories = ["All Deals", "Shopping", "Food", "Hotels", "Activities", "Party", "Other"]
    var category = String()
    var activities = [Activity]()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let str = activitiesCategories[row]
        return NSAttributedString(string: str, attributes: [NSForegroundColorAttributeName:UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activitiesCategories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.category = activitiesCategories[row]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        informationPickers()
    }
    
    func informationPickers() {
        pickerView.delegate = self
        pickerView.dataSource = self
        let middleOfPicker = activitiesCategories.count / 2
        pickerView.selectRow(middleOfPicker, inComponent: 0, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didTouchSearch(_ sender: UIButton) {
        filterDeals()
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "pinsFiltered"), object: activities)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func filterDeals() {
        
        var filteredActivities = [Activity]()

        if self.category == "All Deals" {
            filteredActivities = self.activities
        } else {
            for activity in activities {
                if activity.category == category {
                    filteredActivities.append(activity)
                }
            }
        }
        
        self.activities = filteredActivities
        
    }

    

}
