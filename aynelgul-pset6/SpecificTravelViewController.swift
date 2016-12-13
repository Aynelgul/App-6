//
//  SpecificTravelViewController.swift
//  aynelgul-pset6
//
//  Created by Aynel Gül on 06-12-16.
//  Copyright © 2016 Aynel Gül. All rights reserved.
//

import UIKit
import Firebase

class SpecificTravelViewController: UIViewController {
    
    
    // Outlets.
    @IBOutlet weak var countryOulet: UILabel?
    
    @IBOutlet weak var capitalOutlet: UILabel!
    
    @IBOutlet weak var populationOutlet: UILabel!
    
    @IBOutlet weak var currencyOutlet: UILabel!
    
    var countryreceiver = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        countryOulet?.text = self.countryreceiver
        HTTPSrequest(title: "Australia")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func HTTPSrequest(title: String) {
        let title = title.replacingOccurrences(of: " ", with: "+")
        let url = URL(string: "https://restcountries.eu/rest/v1/name/"+title+"?fullText=true")
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print(error!, "Could not load!")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [AnyObject]

                DispatchQueue.main.async {
//                    let region = json["region"] as! String
//                    let timezones = json["timezones"] as! NSArray
//                    let borders = json["borders"] as! NSArray
//                    let languages = json["languages"] as! NSArray
//                    let currencies = json["currencies"] as! NSArray
                    
                    let capital = json[0]["capital"]! as! String 
                    print("TEST: \(capital)")
                    
                    let population = json[0]["population"]!
                    print("TEST: \(population)")
                    
                    let currency = json[0]["currencies"] as! NSArray
                    print("TEST: \(currency)")
                    
                    let testcur = currency[0] as! String
                    
                    self.capitalOutlet.text = capital
                    self.populationOutlet.text = String(describing: population!)
                    self.currencyOutlet.text = testcur
                }
            } catch {
                print(error,"Country not found.")
            }
        }).resume()
    
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
