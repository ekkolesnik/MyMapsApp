//
//  TrackModel.swift
//  MaspApp
//
//  Created by Evgeny Kolesnik on 08.04.2021.
//

import Foundation
import RealmSwift
import CoreLocation

class TrackModel: Object {
    @objc dynamic var id: Int = 0
    let locationPoints = List<Coordinate>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func addPoint(coordinate: CLLocationCoordinate2D) {
        locationPoints.append(Coordinate(coordinate: coordinate))
    }
}
