//
//  MyDealsViewController.swift
//  DailyDeals
//
//  Description:
//  In this ViewController a user with a company account can view their added deals and delete them if needed. 
//
//  Created by practicum on 31/01/17.
//  Copyright © 2017 Jill de Ron. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class MyDealsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Outlet.
    @IBOutlet weak var myDealsTableView: UITableView!
    
    // MARK: Variables. 
    var dealsOfUser = [Deal]()
    var ref = FIRDatabase.database().reference(withPath: "deals")
    let currentUser = (FIRAuth.auth()?.currentUser?.uid)!
    var nameDeal = String()
    var nameCompany = String()
    
    // MARK: Standard functions. 
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDealsUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: TableView functions. 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(dealsOfUser.count)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deal = dealsOfUser[indexPath.row]
        nameDeal = deal.nameDeal
        nameCompany = deal.nameCompany
        self.performSegue(withIdentifier: "toMoreInformation", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        let deal = dealsOfUser[indexPath.row]
        
        cell.textLabel?.text = deal.nameDeal
        
        return(cell)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // Delete deal in Firebase.
        if editingStyle == .delete {
            let deal = dealsOfUser[indexPath.row]
            deal.ref?.removeValue()
        }
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "deletedDeals"), object: nil)
    }

    // MARK: Get deals of the company account from the current user.
    private func loadDealsUser() {
        ref.observe(.value, with: { snapshot in
            var ownDeals: [Deal] = []
            
            for item in snapshot.children {
                let ownDeal = Deal(snapshot: item as! FIRDataSnapshot)
                
                if ownDeal.uid == self.currentUser {
                    ownDeals.append(ownDeal)
                }
            }
            
            self.dealsOfUser = ownDeals
            self.myDealsTableView.reloadData()
        })
    }
    
    // MARK: Segues. 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMoreInformation" {
            let destination = segue.destination as? InformationDealViewController
            
            // Define variables you want to sent to next ViewController.
            destination?.nameDealReceiver = self.nameDeal
            destination?.nameCompanyReceiver = self.nameCompany
        }
    }
    
}
