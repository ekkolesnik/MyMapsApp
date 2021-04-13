//
//  RootSegue​.swift
//  MaspApp
//
//  Created by Evgeny Kolesnik on 03.10.2020.
//

import UIKit

class RootSegue: UIStoryboardSegue {
    override func perform() {
//        UIApplication​.shared.keyWindow?.rootViewController = destination
        UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.rootViewController = destination
    }
}
