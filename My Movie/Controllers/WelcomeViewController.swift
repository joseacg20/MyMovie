//
//  WelcomeViewController.swift
//  My Movie
//
//  Created by Jose Angel Cortes Gomez on 17/01/21.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Colocar una imagen en el NavigationController
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "Background.png")?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
    }
}
