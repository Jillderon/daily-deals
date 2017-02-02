//
//  SignUpViewController.swift
//  DailyDeals
//
//  Description: 
//  This ViewController let a user sign up. 
//  The user has to fill in his/her email, password, password confirmation 
//  and type of user account (costumer or company).
//
//  Created by practicum on 12/01/17.
//  Copyright © 2017 Jill de Ron. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {
    
    // MARK: Outlets.
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldConfirm: UITextField!
    @IBOutlet weak var ControllerType: UISegmentedControl!
    
    // MARK: Variables.
    let ref = FIRDatabase.database().reference(withPath: "Users")
    let user = FIRAuth.auth()?.currentUser
    
    // MARK: Actions.
    @IBAction func signUpDidTouch(_ sender: Any) {
        errorChecking()
        addUserFirebase()
    }
    
    // MARK: Standard functions.
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Functions needed for checking in (adding user and error checking).
    private func errorChecking() {
        guard textFieldEmail.text! != "" && textFieldPassword.text! != "" && textFieldConfirm.text! != "" else {
            self.alert(title: "Error to register", message: "Enter a valid email, password and confirm password. \n Your password should be at least 6 characters long")
            return
        }
        
        guard textFieldPassword.text!.characters.count >= 6 else {
            self.alert(title: "Error to register", message: "Your password should be at least 6 characters long")
            return
        }
        
        guard textFieldPassword.text! == textFieldConfirm.text! else {
            self.alert(title: "Error to register", message: "The passwords do not match")
            return
        }
    }
    
    private func addUserFirebase() {
        // Create user in Firebase.
        FIRAuth.auth()!.createUser(withEmail: self.textFieldEmail.text!, password: textFieldPassword.text!) { (user, error) in
            if error != nil {
                self.alert(title: "Error to register", message: "Error with database")
                return
            }
            
            // Create complete user profile.
            let user = User(uid: (user?.uid)!,
                            email: self.textFieldEmail.text!,
                            type: self.ControllerType.selectedSegmentIndex)
            
            
            let userRef = self.ref.child((user.uid))
            userRef.setValue(user.toAnyObject())
            
            // Autorization of user. If autorized send user to MapViewController. 
            FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
                if user != nil {
                    self.performSegue(withIdentifier: "toMapView", sender: nil)
                }
            }
        }
    }
    
    // MARK: Alert.
    private func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title , message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
