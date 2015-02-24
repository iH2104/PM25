//
//  ViewController.swift
//  pm25
//
//  Created by JAY on 2015. 2. 23..
//  Copyright (c) 2015년 jay. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
            
            if ( error != nil ) {
                println("Error: " + error.localizedDescription)
                return
            }
            
            let pm = placemarks[0] as CLPlacemark
            self.displayLocationInfo(pm)
            
        })
    }
    
    @IBOutlet weak var locality: UILabel!
    @IBOutlet weak var pm10Level: UILabel!
    @IBOutlet weak var pm25Level: UILabel!
    @IBOutlet weak var maskYn: UILabel!
    @IBOutlet weak var bikeYn: UILabel!
    
    func displayLocationInfo(placemark: CLPlacemark) {
        self.locationManager.stopUpdatingLocation()
        
//        println(placemark.locality)
//        println(placemark.postalCode)
//        println(placemark.administrativeArea)
//        println(placemark.country)
        
        locality.text = placemark.locality
        pm10Level.text = "PM10  30µ/m³"
        pm25Level.text = "PM2.5 15µ/m³"
        maskYn.text = "🙌 Wearing a Mask"
        bikeYn.text = "👋 Riding a bicycle"
    }

    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error: " + error.localizedDescription)
    }
}
