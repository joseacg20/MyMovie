//
//  FavoritesViewController.swift
//  My Movie
//
//  Created by Jose Angel Cortes Gomez on 07/01/21.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore

class FavoritesViewController: UIViewController {
    
    var id: Int?
    var name: String?
    var miMovie = [MyMovie]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Favoritos"
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.createSpinnerView(time: 0.5)
        self.loadMovies()
    }
    
    func createSpinnerView(time: Double) {
        let child = SpinnerViewController()

        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            // then remove the spinner view controller
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
    
    func loadMovies() {
        self.miMovie.removeAll()
        
        let user = Auth.auth().currentUser
        if let user = user {
            let email = user.email
            
            let db = Firestore.firestore()
            db.collection(email!).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    // Se obtuvieron los datos de manera correcta
                    for document in querySnapshot!.documents {
                        let id = document.data()["id"] as! Int
                        let movieID = document.documentID
                        let name = document.data()["name"] as! String
                        let year = document.data()["year"] as! String
                        self.addMovies(id: id, movieID: movieID, name: name, year: year)
                    }
                    self.createSpinnerView(time: 0.5)
                }
            }
        }
        self.tableView.reloadData()
    }
    
    func addMovies(id: Int, movieID: String, name: String, year: String) {
        var newMovie = MyMovie()
        newMovie.id = id
        newMovie.movieID = movieID
        newMovie.name = name
        newMovie.year = year
        self.miMovie.append(newMovie)
        self.tableView.reloadData()
    }
    
    func deleteMovie(id: String) {
        let user = Auth.auth().currentUser

        if let user = user {
            let email = user.email
            
            let db = Firestore.firestore()
            db.collection(email!).document(String(id)).delete() { err in
                if let err = err {
                    print("Error: \(err.localizedDescription)")
                } else {
                    print("Dato eliminado")
                }
            }
            self.loadMovies()
        }
    }
}

// MARK: - Metodos para el TableView
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if miMovie.count == 0 {
            self.createSpinnerView(time: 1.0)
            tableView.setEmptyView(title: "No tienes ningúna pelicula.", message: "Tus peliculas estarán aquí.")
        }
        else {
            tableView.restore()
        }
        return miMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.miMovie[indexPath.row].name
        cell.detailTextLabel?.text = self.miMovie[indexPath.row].year
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Eliminar") {  (contextualAction, view, boolValue) in self.deleteMovie(id: self.miMovie[indexPath.row].movieID!)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [delete])
        return swipeActions
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Obtener el valor de la celda para buscar los datos en CoreData
        let cell = sender as! UITableViewCell
        let indexPath = self.tableView.indexPath(for: cell)
        id = miMovie[indexPath!.row].id ?? 0
        name = miMovie[indexPath!.row].name
        
        if segue.identifier == "movieDetail" {
            let objMovie = segue.destination as! MovieDetailViewController
            objMovie.id = id ?? 0
            objMovie.name = name
        }
    }
}

extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
