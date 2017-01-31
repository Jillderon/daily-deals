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

    // MARK: User defaults.
    let defaults = UserDefaults.standard
    
    // MARK: Outlets.
    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword: UITextField!
    @IBOutlet weak var ButtonLogin: UIButton!
    
    // MARK: Actions.
    @IBAction func loginDidTouch(_ sender: Any) {
        FIRAuth.auth()!.signIn(withEmail: textFieldLoginEmail.text!,
                               password: textFieldLoginPassword.text!) {
            (user, error) in
            if error != nil {
                self.alert(title: "Error with loggig in", message: "Enter a valid email and password.")
            }
            self.defaults.set(self.textFieldLoginEmail.text, forKey: "email")
            self.performSegue(withIdentifier: "toMap", sender: self)
        }
    }
    
    @IBAction func resettingPasswordDidTouch(_ sender: Any) {
        if textFieldLoginEmail.text != "" {
            resetPassword(email: textFieldLoginEmail.text!)
        } else {
            alert(title: "Invalid entry", message: "Fill in your email to reset your password")
        } 
    }
        
    // MARK: Standard functions.
    override func viewDidLoad() {
        super.viewDidLoad()
        segueToMap()
        hideKeyboardWhenTappedAround()
    }

    // MARK: Functions needed for loggin in.
    func resetPassword(email: String) {
        FIRAuth.auth()!.sendPasswordReset(withEmail: email, completion: {(error) in
            if error == nil {
                self.alert(title: "Resetting password", message: "You received an email to reset your password")
            } else {
                self.alert(title: "Oops", message: (error?.localizedDescription)!)
            }
            
        })
    }
    
    func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Segues.
    func segueToMap() {
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "toMap", sender: nil)
            }
        }
        textFieldLoginPassword.text = ""
    }

}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldLoginEmail {
            textFieldLoginPassword.becomeFirstResponder()
        }
        if textField == textFieldLoginPassword {
            textField.resignFirstResponder()
        }
        return true
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
