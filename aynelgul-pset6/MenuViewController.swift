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
    let ref = FIRDatabase.database().reference(withPath: "travel-items")
    
    // MARK: Actions
    @IBAction func addNewTravel(_ sender: UIButton) {
        // alert, vragen om land/stad (hangt van API af)
        
        let alert = UIAlertController(title: "Save", message: "New adventure:", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = ""
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField?.text)")
            
            let text = textField!.text
            
            let travelItem = TravelItem(name: text!//,
//                                        addedByUser: self.user.email)
            // 3
            let TravelItemRef = self.ref.child(text!.lowercased())
            
            // 4
            TravelItemRef.setValue(travelItem.toAnyObject())
            
            
//            self.tableView.reloadData()

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
