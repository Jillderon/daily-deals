//
//  SearchDealViewController.swift
//  DailyDeals
//
//  Created by practicum on 12/01/17.
//  Copyright © 2017 Jill de Ron. All rights reserved.
//

import UIKit

class SearchDealViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    // MARK: Outlets.
    @IBOutlet weak var pickerView: UIPickerView!
    
    // MARK: Variables. 
    let activities = ["All Deals", "Shopping", "Food", "Hotels", "Activities", "Festivals", "Party", "Other"]
    var category = String()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let str = activities[row]
        return NSAttributedString(string: str, attributes: [NSForegroundColorAttributeName:UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.category = activities[row]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMapAgain" {
            let destination = segue.destination as? MapViewController
            destination?.receivedCategory = self.category
        }
    }
    
    @IBAction func didTouchSearch(_ sender: UIButton) {
        performSegue(withIdentifier: "toMapAgain", sender: nil)
    }


}
