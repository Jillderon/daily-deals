//
//  LoginViewController.swift
//  DailyDeals
//
//  Created by practicum on 12/01/17.
//  Copyright © 2017 Jill de Ron. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginDidTouch(_ sender: Any) {
//        FIRAuth.auth()!.signIn(withEmail: textFieldLoginEmail.text!,
//                               password: textFieldLoginPassword.text!) {
//            (user, error) in
//            if error != nil {
//                    self.alert(title: "Error with loggig in", message: "Enter a valid email and password.")
//            }
            self.performSegue(withIdentifier: "toMap", sender: self)
//        }
    }
    
    func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
 

}
