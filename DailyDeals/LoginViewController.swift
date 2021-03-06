//
//  LoginViewController.swift
//  DailyDeals
//
//  Description:
//  In this ViewController the user can log in (with email and password) to enter the rest of the app.
//  If the user doesn't have their is a button to go to a sign up screen. 
//  If the user forgot his or her password their is a button that will send a reset password email.
//
//  Created by practicum on 12/01/17.
//  Copyright © 2017 Jill de Ron. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    // MARK: Outlets.
    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword: UITextField!
    @IBOutlet weak var ButtonLogin: UIButton!
    
    // MARK: User defaults.
    let defaults = UserDefaults.standard
    
    // MARK: Actions.
    @IBAction func loginDidTouch(_ sender: Any) {
        LogInFirebase()
    }
    
    @IBAction func resettingPasswordDidTouch(_ sender: Any) {
        if textFieldLoginEmail.text != "" {
            resetPassword(email: textFieldLoginEmail.text!)
        } else {
            alert(title: "Invalid entry", message: "Fill in your email to reset your password")
        }
    }
        
    // MARK: Standard function.
    override func viewDidLoad() {
        super.viewDidLoad()
        segueToMap()
        hideKeyboardWhenTappedAround()
    }

    // MARK: Functions needed for the functionality buttons.
    private func resetPassword(email: String) {
        FIRAuth.auth()!.sendPasswordReset(withEmail: email, completion: {(error) in
            if error == nil {
                self.alert(title: "Resetting password", message: "You received an email to reset your password")
            } else {
                self.alert(title: "Oops", message: (error?.localizedDescription)!)
            }
        })
    }
    
    private func LogInFirebase() {
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
    
    // MARK: Alert
    private func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Segues.
    private func segueToMap() {
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
