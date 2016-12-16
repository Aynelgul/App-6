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

    var items: [TravelItem] = []
    var country_segue_name: String!
    
    let ref = FIRDatabase.database().reference(withPath: "travel-items")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.observe(.value, with: { snapshot in
            var newItems: [TravelItem] = []
            
            for item in snapshot.children {
                let travelItem = TravelItem(snapshot: item as! FIRDataSnapshot)
                newItems.append(travelItem)
            }
            
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = items[indexPath.row].name
        print(name)
        self.country_segue_name = name
        print(self.country_segue_name)
        
        performSegue(withIdentifier: "detailView", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let travelItem = items[indexPath.row]
            travelItem.ref?.removeValue()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailView" {
            let destination = segue.destination as? SpecificTravelViewController
            print(self.country_segue_name)
            destination?.countryreceiver = self.country_segue_name
        }
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
