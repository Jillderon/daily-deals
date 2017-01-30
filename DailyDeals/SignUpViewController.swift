//
//  SignUpViewController.swift
//  DailyDeals
//
//  Created by practicum on 12/01/17.
//  Copyright © 2017 Jill de Ron. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {

    // MARK: Variables.
    let ref = FIRDatabase.database().reference(withPath: "Users")
    let user = FIRAuth.auth()?.currentUser
    
    // MARK: Outlets.
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldConfirm: UITextField!
    @IBOutlet weak var ControllerType: UISegmentedControl!
    
    // MARK: Actions
    @IBAction func signUpDidTouch(_ sender: Any) {
        errorChecking()
        addUserFirebase()
    }
    
    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title , message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func errorChecking() {
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
    
    func addUserFirebase() {
        // Save user in Firebase.
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
            
            FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
                if user != nil {
                    self.performSegue(withIdentifier: "toMap", sender: nil)
                }
            }
        }
    }
}
