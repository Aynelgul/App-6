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
    @IBOutlet weak var regionOutlet: UILabel!
    @IBOutlet weak var flagImageOutlet: UIImageView!
    
    var countryreceiver = String()
    var imageAlpha3Code = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryOulet?.text = self.countryreceiver
        HTTPSrequest(title: self.countryreceiver)
        HTTPSrequestImage(title: self.imageAlpha3Code)
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
                    
                    let capital = json[0]["capital"]! as! String 
                    print("TEST: \(capital)")
                    
                    let population = json[0]["population"]!
                    print("TEST: \(population)")
                    
                    let currency = json[0]["currencies"] as! NSArray
                    print("TEST: \(currency)")
                    
                    let testcur = currency[0] as! String
                    
                    let region = json[0]["region"]! as! String
                    print("TEST: \(region)")
                    
                    let alpha3Code = json[0]["alpha3Code"] as! String
                    print("TEST: \(alpha3Code)")
                    
                    self.capitalOutlet.text = capital
                    self.populationOutlet.text = String(describing: population!)
                    self.currencyOutlet.text = testcur
                    self.regionOutlet.text = region
                    
                    self.imageAlpha3Code = alpha3Code
                    print("TEST SELF ALPHA CODE: \(self.imageAlpha3Code)")
                }
            } catch {
                print(error,"Country not found.")
            }
        }).resume()
    
    }
    
    func HTTPSrequestImage(title: String) {
//        let url = URL(string: "http://www.geognos.com/api/en/countries/flag/"+title+".png")
//        let task = URLSession.shared.dataTask(with: url!, completionHandler: { data, response, error in
//            guard let data = data, error == nil else {
//                print(error!, "Could not load image!")
//                return
//            }
//            do {
//                
//                DispatchQueue.main.async {
//                    self.flagImageOutlet.image = UIImage(data: data!)
//
//                }
//            } catch {
//                print(error,"Flag not found.")
//            }
//        }).resume()
        
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
