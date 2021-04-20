//
//  LoginController.swift
//  MaspApp
//
//  Created by Evgeny Kolesnik on 10.04.2021.
//

import UIKit
import RealmSwift
import RxSwift

class LoginController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var registrationButton: UIButton!
    
    let realm = try! Realm()
    
    var userObserver: Observable<Results<User>>?
    
    var login = ""
    var pass = ""
    
    var realmLogin = ""
    var realmPass = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Определяем текст и цвет у loginTextField
        loginTextField.attributedPlaceholder = NSAttributedString(string: "Имя пользователя", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightText])
        
        //Определяем текст и цвет у passTextField
        passTextField.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightText])
        
        //закругление кнопок
        enterButton.clipsToBounds = true
        enterButton.layer.cornerRadius = loginTextField.bounds.width / 15
        
        registrationButton.clipsToBounds = true
        registrationButton.layer.cornerRadius = loginTextField.bounds.width / 15
        
    }
    
    func showAuthError() {
        //формируем сам алерт
        let alertVC = UIAlertController(title: "Ошибка", message: "Не верный пароль или логин", preferredStyle: .alert)
        //формируем кнопку к алерту
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        //добавдяем кнопку к алерту
        alertVC.addAction(action)
        
        //выводим на экран
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func enterActionButton(_ sender: Any) {
  
        guard let login = loginTextField.text, let pass = passTextField.text else {return}
        
        let user = realm.objects(User.self)
            .filter("login = '\(String(describing: login))' AND password = '\(String(describing: pass))'")
        
        userObserver = Observable.just(user)
        userObserver?.map({ [unowned self] result -> User? in
            guard let user = result.first(where: { $0.login == login && $0.password == pass})
            else { showAuthError(); return nil }
            
            return user
        })
        .filter({ $0 != nil})
        .subscribe(onNext: { [weak self] user in
            UserDefaults.standard.setValue(true, forKey: "isLogin")
            self?.performSegue(withIdentifier: "enterSegua", sender: AnyObject.self)
        }).disposed(by: .init())
        
    }
    
    @IBAction func registrationActionButton(_ sender: UIButton) {
    }
}
