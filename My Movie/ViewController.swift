//
//  ViewController.swift
//  My Movie
//
//  Created by Jose Angel Cortes Gomez on 06/01/21.
//

import UIKit
import Firebase
import SwiftyGif
import FirebaseCore
import FirebaseFirestore

class ViewController: UIViewController {
    
    var flag = false
        
    let logoAnimationView = LogoAnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        view.addSubview(logoAnimationView)
        logoAnimationView.pinEdgesToSuperView()
        logoAnimationView.logoGifImageView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logoAnimationView.logoGifImageView.startAnimatingGif()
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            // Put your code which should be executed with a delay here
            self.ValidateUserLogIn()
        }
    }

    func ValidateUserLogIn() {
        if Auth.auth().currentUser != nil {
            // User is signed in.
            performSegue(withIdentifier: "userLogInMenu", sender: self)
        } else {
            performSegue(withIdentifier: "welcome", sender: self)
        }
    }
}

extension ViewController: SwiftyGifDelegate {
    func gifDidStop(sender: UIImageView) {
        logoAnimationView.isHidden = true
    }
}
