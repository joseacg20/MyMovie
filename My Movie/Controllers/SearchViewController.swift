//
//  SearchViewController.swift
//  My Movie
//
//  Created by Jose Angel Cortes Gomez on 07/01/21.
//

import UIKit
import SwiftUI

class SearchViewController: UIViewController {
    fileprivate let contentView = UIHostingController(rootView: MovieSearchView())
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
