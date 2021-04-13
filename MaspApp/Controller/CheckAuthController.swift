//
//  CheckAuthController.swift
//  MaspApp
//
//  Created by Evgeny Kolesnik on 10.04.2021.
//

import UIKit

class CheckAuthController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        UserDefaults.standard.setValue(false, forKey: "isLogin")
//
//        DispatchQueue.main.async {
//            
//        
//        if UserDefaults.standard.bool(forKey: "isLogin") {
//            self.performSegue(withIdentifier: "toMap", sender: self)
//        } else {
//            self.performSegue(withIdentifier: "toLogin", sender: self)
//        }
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if UserDefaults.standard.bool(forKey: "isLogin") {
            self.performSegue(withIdentifier: "toMap", sender: self)
        } else {
            self.performSegue(withIdentifier: "toLogin", sender: self)
        }
    }
    
    
    
}
