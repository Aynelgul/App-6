//
//  MenuViewController.swift
//  aynelgul-pset6
//
//  Created by Aynel Gül on 06-12-16.
//  Copyright © 2016 Aynel Gül. All rights reserved.
//

import UIKit
import Firebase

class MenuViewController: UIViewController {
    
    
    // MARK: Properties
    var items: [TravelItem] = []
    
    
    @IBAction func logoutButton(_ sender: UIBarButtonItem) {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError.localizedDescription)")
        }
    }
    // MARK: Properties
    let ref = FIRDatabase.database().reference(withPath: "travel-items")
    
    // MARK: Actions
    @IBAction func addNewTravel(_ sender: UIButton) {

        let alert = UIAlertController(title: "New adventure", message: "Add country:", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = ""
        }
        
        // 3. Grab  value from text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            
            let textField = alert?.textFields![0]
            print("Text field: \(textField?.text)")
            
            if textField?.text == "" {
                print("Textfield is empty!")
                
                // Present error alert empty textfield.
                let alertController = UIAlertController(title: "Try again", message:
                    "Please fill in a country.", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
                
                return
                
            }
            
            let travelItem = TravelItem(name: (textField?.text!)!)
            let TravelItemRef = self.ref.child((textField?.text!.lowercased())!)

            TravelItemRef.setValue(travelItem.toAnyObject())
            
            self.performSegue(withIdentifier: "goToTravels", sender: nil)
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
