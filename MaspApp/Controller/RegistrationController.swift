//
//  RegistrationController.swift
//  MaspApp
//
//  Created by Evgeny Kolesnik on 10.04.2021.
//

import UIKit
import RealmSwift

class RegistrationController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registrationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.attributedPlaceholder = NSAttributedString(string: "Логин", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightText])

        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightText])
        
        registrationButton.clipsToBounds = true
        registrationButton.layer.cornerRadius = loginTextField.bounds.width / 15

    }
    
    @IBAction func registrationActionButton(_ sender: Any) {
        
        let login = loginTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        do {
            let realm = try Realm()
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            realm.beginWrite()

            let user = User()
            user.login = login
            user.password = password

            realm.add(user)
            try realm.commitWrite()
            
        } catch {
            
        }
        UserDefaults.standard.setValue(true, forKey: "isLogin")
        performSegue(withIdentifier: "toMapController", sender: sender)
    }
}
