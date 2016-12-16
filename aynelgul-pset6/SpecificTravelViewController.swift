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
    
    
    // MARK: Outlets.
    @IBOutlet weak var countryOulet: UILabel?
    @IBOutlet weak var capitalOutlet: UILabel!
    @IBOutlet weak var populationOutlet: UILabel!
    @IBOutlet weak var currencyOutlet: UILabel!
    @IBOutlet weak var regionOutlet: UILabel!
    @IBOutlet weak var flagImageOutlet: UIImageView!
    
    var countryreceiver = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryOulet?.text = self.countryreceiver
        HTTPSrequest(title: self.countryreceiver)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Functions.
    func HTTPSrequest(title: String) {
        let title = title.replacingOccurrences(of: " ", with: "+")
        let url = URL(string: "https://restcountries.eu/rest/v1/name/"+title+"?fullText=true")
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print(error!, "Could not load!")
                return
            }
            do {
                // IF LET GEBRUIKEN
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? Array<NSDictionary>
                
                if let jsonArray = json {
                
                    DispatchQueue.main.async {
                        
                        let capital = jsonArray[0]["capital"]! as! String
                        let population = jsonArray[0]["population"]!
                        let currency = jsonArray[0]["currencies"] as! NSArray
                        
                        // NOG AANPASSEN
                        let testcur = currency[0] as! String
                        
                        let region = jsonArray[0]["region"]! as! String
                        let alpha2Code = jsonArray[0]["alpha2Code"] as! String
                        
                        self.capitalOutlet.text = capital
                        self.populationOutlet.text = String(describing: population)
                        self.currencyOutlet.text = testcur
                        self.regionOutlet.text = region
                        
                        self.HTTPSrequestImage(title: alpha2Code)
                    }
                    
                } else {
                    print("Country not found.")
                    let alert = UIAlertController(title: "Oops!", message: "Country not found.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            } catch {
                print(error,"Something went wrong!")
            }
        }).resume()
    
    }
    
    func HTTPSrequestImage(title: String) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        if let url = NSURL(string: "http://www.geognos.com/api/en/countries/flag/"+title+".png"){
            
            let task = session.dataTask(with: url as URL, completionHandler: {data, response, error in
                if let err = error {
                    print("Error: \(err)")
                    return
                }
                
                if let http = response as? HTTPURLResponse {
                    if http.statusCode == 200 {
                        let downloadedImage = UIImage(data: data!)
                        DispatchQueue.main.async {
                            self.flagImageOutlet.image = downloadedImage
                        }
                    }
                }
            })
            task.resume()
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
