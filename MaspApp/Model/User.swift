//
//  User.swift
//  MaspApp
//
//  Created by Evgeny Kolesnik on 02.10.2020.
//

import UIKit
import RealmSwift

class User: Object {
    @objc dynamic var login = ""
    @objc dynamic var password = ""
    
    override class func primaryKey() -> String? {
        return "login"
    }
}
