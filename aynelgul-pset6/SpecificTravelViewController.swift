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

    override func viewDidLoad() {
        super.viewDidLoad()

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
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary

                DispatchQueue.main.async {
//                    self.data = json as! [String: String]
//                    self.titles.append(json["Title"] as! String)
//                    self.descriptions[self.data["Title"]!] = self.data["Plot"]
//                    self.TableView.reloadData()
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
