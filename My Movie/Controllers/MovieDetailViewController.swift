//
//  MovieDetailViewController.swift
//  My Movie
//
//  Created by Jose Angel Cortes Gomez on 14/01/21.
//

import UIKit
import SwiftUI

class MovieDetailViewController: UIViewController {
    
    var id: Int?
    var name: String?
    
    fileprivate var contentView = UIHostingController(rootView: MovieDetailView(movieId: 0))

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = name
        contentView = UIHostingController(rootView: MovieDetailView(movieId: id ?? 0))
        septupHC()
        septupConstrains()
    }
    
    fileprivate func septupConstrains() {
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    fileprivate func septupHC() {
        addChild(contentView)
        view.addSubview(contentView.view)
        contentView.didMove(toParent: self)
    }
}
