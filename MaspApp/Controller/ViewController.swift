//
//  ViewController.swift
//  MaspApp
//
//  Created by Evgeny Kolesnik on 24.09.2020.
//

import UIKit
import GoogleMaps
import CoreLocation
import RealmSwift

class ViewController: UIViewController, GMSMapViewDelegate {
    
    private let coordinate = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)
    private var locationManager: CLLocationManager?
    private var beginBackgroundTask: UIBackgroundTaskIdentifier?
    private var traffic = false
    private var trackModel = TrackModel()
    
    //свойство для хранения объекта маршрута (отвечает за рисование маршрута)
    var route: GMSPolyline?
    //маршрут
    var routePath: GMSMutablePath?
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurateLocationManager()
        configurateMap()

    }
    
    func configurateLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.delegate = self
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.pausesLocationUpdatesAutomatically = false
        locationManager?.startMonitoringSignificantLocationChanges()
    }
    
    func configurateMap() {
        mapView.camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 15)
        mapView.delegate = self
        mapView.settings.myLocationButton = true
    }
    
    func start() {
        traffic = true
        route?.map = nil
        route = GMSPolyline()
        routePath = GMSMutablePath()
        route?.map = mapView
        route?.strokeColor = .green
        route?.strokeWidth = 4
        
        trackModel = TrackModel()
        locationManager?.startUpdatingLocation()
    }
    
    func stop() {
        locationManager?.stopUpdatingLocation()
        traffic = false
    }
    
    func save() {
        removeRealm()
        saveRealm()
    }
    
    private func loadRealm() {
        do {
            let realm = try Realm()
            trackModel = realm.objects(TrackModel.self).first ?? TrackModel()
            routePath = GMSMutablePath()
            var coord = CLLocationCoordinate2D()
            trackModel.locationPoints.forEach { coordinate in
                coord = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
                routePath?.add(coord)
            }
            route?.path = routePath
            mapView.animate(toLocation: coord)
        } catch {
            print ( error.localizedDescription )
        }
    }

    private func removeRealm() {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.deleteAll()
            try realm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func saveRealm() {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(trackModel)
            try realm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func startRoute(_ sender: UIBarButtonItem) {
        
        start()

    }
    
    @IBAction func endRoute(_ sender: UIBarButtonItem) {
        
        let realm = try! Realm()
        try! realm.write {
          realm.deleteAll()
        }
        
        stop()
        save()
        
    }
    
    @IBAction func displayRoad(_ sender: UIBarButtonItem) {
        
        if (traffic) {
            let alert = UIAlertController(title: "Внимание!", message: "Необходимо остановить трекинг!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Завершить", style: .default) { [weak self](action) in
                self?.stop()
                self?.loadRealm()
            }
            let cancelAction = UIAlertAction(title: "Продолжить", style: .cancel) { (action) in
            }
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            loadRealm()
        }
    }
    
    @IBAction func exitItemButton(_ sender: UIBarButtonItem) {
        UserDefaults.standard.setValue(false, forKey: "isLogin")
//        performSegue(withIdentifier: "toLoginController", sender: sender)
//        dismiss(animated: true, completion: nil)
    }
    
    
    
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if !traffic { return }
        if let location = locations.first {
            routePath?.add(location.coordinate)
            route?.path = routePath
            trackModel.addPoint(coordinate: location.coordinate)
            mapView.animate(toLocation: location.coordinate)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
