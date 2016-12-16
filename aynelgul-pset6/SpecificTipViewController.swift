//
//  SpecificTipViewController.swift
//  aynelgul-pset6
//
//  Created by Aynel Gül on 16-12-16.
//  Copyright © 2016 Aynel Gül. All rights reserved.
//

import UIKit

class SpecificTipViewController: UIViewController {
    
    // MARK: Outlets.
    @IBOutlet weak var specificTipOutlet: UITextView!
    
    // MARK: Properties.
    var tipreceiver = String()

    // Mark: Functions.
    override func viewDidLoad() {
        super.viewDidLoad()

        specificTipOutlet?.text = self.tipreceiver
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
