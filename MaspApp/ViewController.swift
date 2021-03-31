//
//  ViewController.swift
//  MaspApp
//
//  Created by Evgeny Kolesnik on 31.03.2021.
//

import UIKit
import GoogleMaps
import CoreLocation

class ViewController: UIViewController {
    
    let coordinate = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)
    var locationManager: CLLocationManager?
    var marker: GMSMarker?
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configManager()
        
        //camera
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 17)
        mapView.camera = camera
    }
    
    func configManager() {
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
           // self.removeMarker()
            let marker = GMSMarker(position: location.coordinate)
            marker.map = mapView
            self.marker = marker
            mapView.animate(toLocation: location.coordinate)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
