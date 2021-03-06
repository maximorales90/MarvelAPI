//
//  ViewController.swift
//  MarvelAPI
//
//  Created by Maximiliano Morales on 16/03/2022.
//
import Foundation
import UIKit

class PersonajesViewController: UIViewController, UITableViewDelegate {
    
    var homeData = APIManager()
    var personajes = [Personajes]()
    var viewModels = [PersonsajesCellViewModel]()
    var personajeURL : URL!
       
    let tableView: UITableView = {
        let table = UITableView()
        table.register(PersonajesCell.self, forCellReuseIdentifier: PersonajesCell.identifier)
        return table
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Marvel"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        view.backgroundColor = .systemBackground
        
        homeData.fetchPersonajes(urltest: "test", testActive: false, paginacion: false, completion: {personajesData, jsonData, error in
            self.personajes = personajesData
            self.viewModels = self.personajes.map({
                PersonsajesCellViewModel(
                        title: $0.name,
                        subtitle: $0.description,
                        imageURL: self.homeData.extractImage(data: $0.thumbnail)
                )
            })
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
        })
}

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoWebView" {
            let personajeWebView = segue.destination as! WebViewController
            personajeWebView.url = personajeURL
        }
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
            personajeURL = homeData.extractURL(data: dato)
            self.performSegue(withIdentifier: "gotoWebView", sender: self)
            return
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 162
    }
    
    func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height-100-scrollView.frame.size.height){
            guard !homeData.isPaginacion else {
                return
            }
            self.tableView.tableFooterView = createSpinnerFooter()
            
            homeData.fetchPersonajes(urltest: "test", testActive: false, paginacion: true, completion: {personajesData, jsonData, error in
                print("Obtener mas datos")
                DispatchQueue.main.async {
                    self.tableView.tableFooterView = nil
                }
                self.personajes.append(contentsOf: personajesData)
                self.viewModels = self.personajes.map({
                    PersonsajesCellViewModel(
                            title: $0.name,
                            subtitle: $0.description,
                            imageURL: self.homeData.extractImage(data: $0.thumbnail)
                    )
                })
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            })
        }
            
    }
    
}




