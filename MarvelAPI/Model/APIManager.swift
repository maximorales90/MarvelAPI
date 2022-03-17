//
//  APIManager.swift
//  MarvelAPI
//
//  Created by Maximiliano Morales on 17/03/2022.
//

import Foundation
import CryptoKit

class APIManager {
    
    var fetchedPersonajes: [Personajes] = []
    var offset: Int = 0

   
    func fetchPersonajes(){
        
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(privateKey)\(publicKey)")
        let url = "https://gateway.marvel.com:443/v1/public/characters?limit=20&offset=\(offset)&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
    
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!){ (data, response, err) in
            if let error = err{
                print(error.localizedDescription)
                return
            }
            
            guard let APIData = data else{
                print("No hay datos")
                return
            }
            do{
                let personajes = try JSONDecoder().decode(APIPersonajesResultado.self, from: APIData)
                
                DispatchQueue.main.async {
                    self.fetchedPersonajes.append(contentsOf: personajes.data.results)
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
    func MD5(data: String)->String{
        
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        return hash.map{
            String(format: "%02hhx", $0)
        }
        .joined()
    }
    

}
