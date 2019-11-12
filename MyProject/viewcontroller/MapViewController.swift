//
//  MapViewController.swift
//  MyProject
//
//  Created by Ben on 2019/10/17.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var myMapView: MKMapView!
    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var locationManager: CLLocationManager!
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let currentLocation = locations.first
        self.myLabel.text = "\(currentLocation?.coordinate.latitude),\(currentLocation?.coordinate.longitude)"
    }
}
