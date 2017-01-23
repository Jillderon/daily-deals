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

    // MARK: User defaults
    let defaults = UserDefaults.standard
    
    // MARK: Outlets
    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword: UITextField!
    @IBOutlet weak var ButtonLogin: UIButton!
    
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
    
    func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "toMap", sender: nil)
            }
        }
        textFieldLoginPassword.text = ""
    }
    
    // State restoration. Only saving email and not password, because of security reasons.
    // Cited from: https://www.raywenderlich.com/117471/state-restoration-tutorial
    override func encodeRestorableState(with coder: NSCoder) {
        if let email = textFieldLoginEmail.text {
            coder.encode(email, forKey: "email")
        }
        
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        textFieldLoginEmail.text = coder.decodeObject(forKey: "email") as! String?
        super.decodeRestorableState(with: coder)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textFieldLoginEmail.text = self.defaults.string(forKey: "email")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
