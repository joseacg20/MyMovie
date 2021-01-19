//
//  RegistryViewController.swift
//  My Movie
//
//  Created by Jose Angel Cortes Gomez on 06/01/21.
//

import UIKit
import Firebase

class RegistryViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func AlertMessage(message: String){
        let alert = UIAlertController(title: "Ups", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Registro
    @IBAction func RegisterButton(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text, let userName = nameTextField.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if error == nil {
                    print("User created!")
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = userName
                    changeRequest?.commitChanges { error in
                    }
                }
                
                if let error = error {
                    print(error.localizedDescription)
                    if error.localizedDescription == "The password must be 6 characters long or more." {
                        self.AlertMessage(message: "La contraseña debe tener 6 caracteres o más.")
                    }
                    
                    if error.localizedDescription == "An email address must be provided." {
                        self.AlertMessage(message: "Se debe proporcionar una dirección de correo electrónico.")
                    }
                    if error.localizedDescription == "The email address is badly formatted." {
                        self.AlertMessage(message: "La dirección de correo electrónico está mal formateada.")
                    }
                    if error.localizedDescription == "The email address is already in use by another account." {
                        self.AlertMessage(message: "La dirección de correo electrónico ya está siendo utilizada por otra cuenta.")
                    }
                } else {
                    self.performSegue(withIdentifier: "registrationMenu", sender: self)
                }
            }
        }
    }
}
