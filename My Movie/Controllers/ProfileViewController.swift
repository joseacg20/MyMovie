//
//  ProfileViewController.swift
//  My Movie
//
//  Created by Jose Angel Cortes Gomez on 07/01/21.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        title = "Perfil"
        
        // Colocar una imagen en el NavigationController
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "Background.png")?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
    }
    
    // MARK: - Cerrar Sesion
    @IBAction func LogOutButton(_ sender: UIBarButtonItem) {
        do {
          try Auth.auth().signOut()
            // Regresar a la pantalla inicial
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popToViewController(ofClass: ViewController.self)
        } catch let signOutError as NSError {
            print ("Error al cerrar sesion", signOutError.localizedDescription)
        }
    }
}

extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}
