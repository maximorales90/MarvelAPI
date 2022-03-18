//
//  APIManager.swift
//  MarvelAPI
//
//  Created by Maximiliano Morales on 17/03/2022.
//

import Foundation
import CryptoKit
import UIKit

class APIManager {
    
    static let shared = APIManager()
    
    var fetchedPersonajes: [Personajes] = []
    var offset: Int = 0
       

    func fetchPersonajes(completion: @escaping (Result<[Personajes],Error>) -> Void){
        
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(privateKey)\(publicKey)")
        let url = "https://gateway.marvel.com:443/v1/public/characters?limit=20&offset=\(offset)&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
    
        let task = URLSession(configuration: .default)
        
        task.dataTask(with: URL(string: url)!){ (data, response, err) in
            if let error = err{
                completion(.failure(error))
                print(error.localizedDescription)
                return
            }
            else if let APIData = data{

            do{
                let personajes = try JSONDecoder().decode(APIPersonajesResultado.self, from: APIData)
                print("Personajes:\(personajes.data.count) ")
                print(personajes.data.results)

                completion(.success(personajes.data.results))
                
            }
            catch{
                completion(.failure(error))
                print(error.localizedDescription)
                }
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
    
    func extractImage(data: [String: String])->URL{
        
        let path = data["path"] ?? ""
        print(path)
        let ext = data["extension"] ?? ""
        print(ext)
        
        return URL(string: "\(path).\(ext)")!

    }
                   
    func extractURL(data: [String: String])->URL{
                       
        let url = data["url"] ?? ""
        print(url)
                       
        return URL(string: url)!

    }
    
    func extractURLType(data: [String: String])->String{
                       
        let type = data["type"] ?? ""
        print(type)
                       
        return type.capitalized

    }

}
