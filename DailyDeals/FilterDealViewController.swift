//
//  FilterDealViewController.swift
//  DailyDeals
//
//  Description: 
//  This ViewController displays a pickerView where the user can select a category. 
//  Only deals of this category will be showed in the MapViewController.
// 
//  Created by practicum on 12/01/17.
//  Copyright © 2017 Jill de Ron. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FilterDealViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    // MARK: Outlets.
    @IBOutlet weak var pickerView: UIPickerView!
    
    // MARK: Variables. 
    let dealsCategories = ["All Deals", "Shopping", "Food", "Hotels", "Activities", "Party", "Other"]
    var category = String()
    var deals = [Deal]()
    
    // MARK: Actions.
    @IBAction func didTouchFilter(_ sender: Any) {
        filterDeals()
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "annotationsFiltered"), object: deals)
        self.navigationController!.popViewController(animated: true)
    }

    // MARK: Standard functions.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: PickerView Functions.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let str = dealsCategories[row]
        return NSAttributedString(string: str, attributes: [NSForegroundColorAttributeName:UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dealsCategories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.category = dealsCategories[row]
    }
    
    private func filterDeals() {
        
        // Temporary variable to store filtered deals in.
        var filteredDeals = [Deal]()
        
        if self.category == "All Deals" || self.category == "" {
            filteredDeals = self.deals
        } else {
            for deal in deals {
                if deal.category == category {
                    filteredDeals.append(deal)
                }
            }
        }
        
        self.deals = filteredDeals
    }
}
