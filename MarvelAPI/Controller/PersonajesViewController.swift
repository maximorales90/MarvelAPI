//
//  ViewController.swift
//  MarvelAPI
//
//  Created by Maximiliano Morales on 16/03/2022.
//

import UIKit

class PersonajesViewController: UIViewController {
    
    var homeData = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Personajes de Marvel"
        view.backgroundColor = .systemBackground
        
        homeData.fetchPersonajes()
    
    }


}



