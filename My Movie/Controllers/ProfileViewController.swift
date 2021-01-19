//
//  ProfileViewController.swift
//  My Movie
//
//  Created by Jose Angel Cortes Gomez on 07/01/21.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseFirestore

class ProfileViewController: UIViewController, UINavigationControllerDelegate {

    var email: String?

    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Perfil"
        
        // Volver redondo el ImageView
        self.imageUser.layer.masksToBounds = true
        self.imageUser.layer.cornerRadius = self.imageUser.bounds.width / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.createSpinnerView()
        self.loadDataUser()
    }

    func createSpinnerView() {
        let child = SpinnerViewController()

        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // then remove the spinner view controller
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
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
    
    func loadDataUser(){
        let user = Auth.auth().currentUser
        if let user = user {
            let email = user.email
            let name = user.displayName
            self.mailTextField.text = email
            self.nameTextField.text = name
        }
    }
    
    @IBAction func changeImage(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func changeNameUserButton(_ sender: UIButton) {
        // Creaccion del Alert
        let alert = UIAlertController(title: "Modificar Nombre", message: nil, preferredStyle: .alert)
        // Creacion de Textfield
        alert.addTextField { (nameAlert) in
            nameAlert.placeholder = "Nombre"
        }
        // Creacion del Alert Aceptar y Cancelar
        let actionCancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let actionAlert = UIAlertAction(title: "Aceptar", style: .default) { (_) in
            // Variables para almacenar el contacto
            guard let nameAlert = alert.textFields?.first?.text else { return }
            let user = Auth.auth().currentUser
            if let user = user {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = nameAlert
                changeRequest.commitChanges { error in
                    if let error = error {
                      // An error happened.
                        print("Error: \(error.localizedDescription)")
                    } else {
                      // Profile updated.
                        print("Actualizacion Correcta")
                        self.viewWillAppear(true)
                    }
                }
            }
        }
        // Añadir Actions al Alert
        alert.addAction(actionAlert)
        alert.addAction(actionCancel)
        // Presentacion del alert
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func changeEmailUserButton(_ sender: UIButton) {
        // Creaccion del Alert
        let alert2 = UIAlertController(title: "Modificar Correo", message: nil, preferredStyle: .alert)
        // Creacion de Textfield
        alert2.addTextField { (emailAlert) in
            emailAlert.placeholder = "Correo"
        }
        // Creacion del Alert Aceptar y Cancelar
        let actionCancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let actionAlert = UIAlertAction(title: "Aceptar", style: .default) { (_) in
            // Variables para almacenar el contacto
            guard let emailAlert = alert2.textFields?.first?.text else { return }
            let email = emailAlert
            Auth.auth().currentUser?.updateEmail(to: email) { (error) in
                if let error = error {
                    // An error happened.
                    print("Error: \(error.localizedDescription)")
                } else {
                    // Profile updated.
                    print("Actualizacion Correcta")
                    self.viewWillAppear(true)
                }
            }
        }
        // Añadir Actions al Alert
        alert2.addAction(actionAlert)
        alert2.addAction(actionCancel)
        // Presentacion del alert
        present(alert2, animated: true, completion: nil)
    }
}

extension UINavigationController {
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            popToViewController(vc, animated: animated)
        }
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate {
    // MARK: Metodos de los delegados para el PickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagen = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage
        imageUser.image = imagen
        picker.dismiss(animated: true, completion: nil)

//        let user = Auth.auth().currentUser
//        if let user = user {
//            let changeRequest = user.createProfileChangeRequest()
//            changeRequest.photoURL = NSURL(string: "https://example.com/jane-q-user/profile.jpg") as URL?
//            changeRequest.commitChanges { error in
//                if let error = error {
//                  // An error happened.
//                    print("Error: \(error.localizedDescription)")
//                } else {
//                  // Profile updated.
//                    print("Actualizacion Correcta")
//                }
//            }
//        }
    }
    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
//        var databaseRef: DatabaseReference!
//        databaseRef = Database.database().reference()
//            
//        let storage = Storage.storage()
//        let storageReference = storage.reference()
//        imageUser.image = image
//        dismiss(animated: true, completion: nil)
//        var data = NSData()
//        data = imageUser.image!.jpegData(compressionQuality: 0.8)! as NSData
//        // set upload path
//        let filePath = "\(Auth.auth().currentUser!.uid)/\("userPhoto")"
//        let metaData = StorageMetadata()
//        metaData.contentType = "image/jpg"
//        storageReference.child(filePath).putData(data as Data, metadata: metaData){(metaData,error) in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//                return
//            } else {
//                //store downloadURL
//                let downloadURL = URL(string: "path/to/image")!
//                
////                let downloadURL = metaData!.downloadURL()!.absoluteString
//                //store downloadURL at database
//                self.databaseRef.child("users").child(Auth.auth().currentUser!.uid).updateChildValues(["userPhoto": downloadURL])
//            }
//        }
//    }
}
