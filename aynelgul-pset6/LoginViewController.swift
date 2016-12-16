//
//  LoginViewController.swift
//  aynelgul-pset6
//
//  Created by Aynel Gül on 06-12-16.
//  Copyright © 2016 Aynel Gül. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    // MARK: User defaults.
    let defaults = UserDefaults.standard
    
    
    // MARK: Outlets
    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword: UITextField!
    
    // MARK: Actions
    @IBAction func loginTouch(_ sender: UIButton) {
        guard let email = textFieldLoginEmail.text, let password = textFieldLoginPassword.text else { return
        }
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                
                let alert = UIAlertController(title: "Oops!", message: "That e-mailadress and/or password is not correct! Try again or sign up.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        
                return
            }
            self.signedIn(user!)
            self.defaults.set(self.textFieldLoginEmail.text ,forKey: "email")

        }
    }
    
    @IBAction func signupTouch(_ sender: UIButton) {
        guard let email = textFieldLoginEmail.text, let password = textFieldLoginPassword.text else { return }
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                
                // Check if e-mail is not used already
                if error.localizedDescription == "The email address is already in use by another account." {
                    let alert = UIAlertController(title: "Oops!", message: "The email address is already in use by another account.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
                if error.localizedDescription == "The password must be 6 characters long or more." {
                    let alert = UIAlertController(title: "Oops!", message: "The password must be 6 characters long or more.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
                let alert = UIAlertController(title: "Oops!", message: "Sign up failed. Please fill in all fields or check your e-mailadress.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return
            }
            self.setDisplayName(user!)
            self.defaults.set(self.textFieldLoginEmail.text ,forKey: "email")
        }
    }
    
    // MARK: Functions.
    func setDisplayName(_ user: FIRUser) {
        let changeRequest = user.profileChangeRequest()
        changeRequest.displayName = user.email!.components(separatedBy: "@")[0]
        changeRequest.commitChanges(){ (error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.signedIn(FIRAuth.auth()?.currentUser)
        }
    }
    
    func signedIn(_ user: FIRUser?) {
        textFieldLoginPassword.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        if let user = FIRAuth.auth()?.currentUser {
            self.signedIn(user)
        }
        
        // Listener for state change of user.
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "gotoMenu", sender: nil)
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textFieldLoginEmail.text = self.defaults.string(forKey: "email")
    }
    
    // Function when tap is recognized.
    func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        if let email = textFieldLoginPassword.text {
            coder.encode(email, forKey: "LoginTextfieldPassword")
        }
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        textFieldLoginPassword.text = coder.decodeObject(forKey: "LoginTextfieldPassword") as! String?
        super.decodeRestorableState(with: coder)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
