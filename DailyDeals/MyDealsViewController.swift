//
//  MyDealsViewController.swift
//  DailyDeals
//
//  Created by practicum on 31/01/17.
//  Copyright © 2017 Jill de Ron. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class MyDealsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: Variables. 
    var dealsOfUser = [Deal]()
    var ref = FIRDatabase.database().reference(withPath: "deals")
    let currentUser = (FIRAuth.auth()?.currentUser?.uid)!
    @IBOutlet weak var myDealsTableView: UITableView!
 
    
    // MARK: Standard functions. 
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDealsUser()
        print(dealsOfUser)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: TableView functions. 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(dealsOfUser.count)

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
    }

    // MARK: Get deals of user.
    func loadDealsUser() {
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
    

}
