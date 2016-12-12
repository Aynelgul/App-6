//
//  TravelsViewController.swift
//  aynelgul-pset6
//
//  Created by Aynel Gül on 10-12-16.
//  Copyright © 2016 Aynel Gül. All rights reserved.
//

import UIKit
import Firebase

class TravelsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var travelTableView: UITableView!
    var test = ["test", "oke", "nr3"]
    var items: [TravelItem] = []
    
    let ref = FIRDatabase.database().reference(withPath: "travel-items")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ref.observe(.value, with: { snapshot in
            // 2
            var newItems: [TravelItem] = []
            
            // 3
            for item in snapshot.children {
                // 4
                let travelItem = TravelItem(snapshot: item as! FIRDataSnapshot)
                newItems.append(travelItem)
            }
            
            // 5
            self.items = newItems
            self.travelTableView.reloadData()

        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! UserTravelsCell
        
        let item = items[indexPath.row]
        
        cell.countryLabel?.text = item.name
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailView", sender: nil)
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
