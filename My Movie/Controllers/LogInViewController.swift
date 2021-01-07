//
//  LogInViewController.swift
//  My Movie
//
//  Created by Jose Angel Cortes Gomez on 06/01/21.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {

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
    

    // MARK: - Inicio de Sesion
    @IBAction func LogInButton(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
              // ...
                if let error = error {
                    print(error.localizedDescription)
                    
                    if error.localizedDescription == "The password is invalid or the user does not have a password." {
                        self.AlertMessage(message: "La contraseña no es válida o no ingresaste una contraseña.")
                    }
                    
                    if error.localizedDescription == "The email address is badly formatted." {
                        self.AlertMessage(message: "La dirección de correo electrónico está mal formateada.")
                    }
                    
                    if error.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted." {
                        self.AlertMessage(message: "No hay ningún registro de usuario que corresponda a este correo. Es posible que se haya eliminado al usuario o no estes registrado.")
                    }
                } else {
                    if let responseFirebase = authResult {
                        print("\(responseFirebase.user)")
                        // Redireccion al usuario al menu principal
                        self.performSegue(withIdentifier: "logInMenu", sender: self)
                    }
                }
            }
        }
    }
    
}
