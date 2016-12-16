//
//  TipsViewController.swift
//  aynelgul-pset6
//
//  Created by Aynel Gül on 06-12-16.
//  Copyright © 2016 Aynel Gül. All rights reserved.
//

import UIKit
import Firebase

class TipsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Outlets.
    @IBOutlet weak var tipsTableViewOutlet: UITableView!
  
    
    // MARK:
    var tips = ["Pack A Scarf: This simple piece of cotton cloth is one of my most useful travel accessories with many different practical applications. It’s great for sun protection, a makeshift towel, carrying stuff around, an eye mask, and much more.", "Back Everything Up: Keep both digital and physical copies of your passport, visas, driver’s license, birth certificate, health insurance card, serial numbers, and important phone numbers ready to go in case of an emergency.", "Try Couchsurfing: Couchsurfing.org is a large online community of travelers who share their spare rooms or couches with strangers for free. If you truly want to experience a country and it’s people, staying with a local is the way to go.", "Volunteer Occasionally: There’s a great site called Grassroots Volunteering where you can search for highly recommended volunteer opportunities around the world.", "Pack Ear Plugs: Muffle the sounds of crying babies, drunk Australians, barking dogs, honking horns, dormitory sex, natural gas salesmen, and more. A traveler’s best friend.", "Don’t Forget Travel Insurance: With travel insurance you don’t have to worry about huge hospital bills or stolen gear when it eventually happens.", "Learn Common Phrases of the Local Language: A simple “Please,” “Thank you,” and “I’m sorry” in the local language goes a long way. I also like to learn the word for beer, but that’s just me."]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tipsCell", for: indexPath) as! TipsCell
        
        let tip = tips[indexPath.row]
        cell.tipsLabel.text = tip
        
        return cell
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
