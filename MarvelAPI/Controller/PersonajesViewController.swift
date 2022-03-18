//
//  ViewController.swift
//  MarvelAPI
//
//  Created by Maximiliano Morales on 16/03/2022.
//
import Foundation
import UIKit
import SafariServices

class PersonajesViewController: UIViewController, UITableViewDelegate {
        
    var homeData = APIManager()
    var personajes = [Personajes]()
    var viewModels = [PersonsajesCellViewModel]()

    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(PersonajesCell.self, forCellReuseIdentifier: PersonajesCell.identifier)
        return table
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Personajes de Marvel"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        
        APIManager.shared.fetchPersonajes{ [weak self] result in
            switch result {
            case .success(let personajes):
                self?.personajes = personajes
                self?.viewModels = personajes.map({
                    PersonsajesCellViewModel(
                        title: $0.name,
                        subtitle: $0.description,
                        imageURL: APIManager.shared.extractImage(data: $0.thumbnail)
                        )
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
            
        }
        print(APIManager.shared.fetchedPersonajes)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension PersonajesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonajesCell.identifier, for: indexPath) as? PersonajesCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let personaje = personajes[indexPath.row]
        for dato in personaje.urls{
            let url = APIManager.shared.extractURL(data: dato)
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
            return
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}




