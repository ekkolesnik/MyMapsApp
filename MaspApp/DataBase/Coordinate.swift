//
//  Realm.swift
//  MaspApp
//
//  Created by Evgeny Kolesnik on 08.04.2021.
//

import Foundation
import RealmSwift
import CoreLocation

class Coordinate: Object {
    @objc dynamic var latitude = 0.0
    @objc dynamic var longitude = 0.0
    
//    var coordinate: CLLocationCoordinate2D {
//        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//    }
    
    convenience init(coordinate: CLLocationCoordinate2D) {
        self.init()
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
}
