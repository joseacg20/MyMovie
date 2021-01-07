//
//  SearchViewController.swift
//  My Movie
//
//  Created by Jose Angel Cortes Gomez on 07/01/21.
//

import UIKit
import Firebase

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Buscar"
        
        // Colocar una imagen en el NavigationController
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "Background.png")?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
    }
}
