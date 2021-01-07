//
//  ViewController.swift
//  My Movie
//
//  Created by Jose Angel Cortes Gomez on 06/01/21.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Colocar una imagen en el NavigationController
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "Background.png")?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        
        ValidateUserLogIn()
    }
    
    func ValidateUserLogIn() {
        if Auth.auth().currentUser != nil {
          // User is signed in.
          performSegue(withIdentifier: "userLogInMenu", sender: self)
        }
    }
}
