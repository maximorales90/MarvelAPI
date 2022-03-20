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
        
    var fetchedPersonajes: [Personajes] = []
    var offset: Int = 0

    func fetchPersonajes(urltest : String,testActive: Bool,completion:@escaping (_ personajesData: [Personajes], _ jsonData: Data? , _ error:Error?)->()){
        
        var url: String
        
        if testActive {
            url = urltest
        } else {
            let ts = String(Date().timeIntervalSince1970)
            let hash = MD5(data: "\(ts)\(privateKey)\(publicKey)")
            url = "https://gateway.marvel.com:443/v1/public/characters?limit=20&offset=\(offset)&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        }
            
        let task = URLSession(configuration: .default)
        
        task.dataTask(with: URL(string: url)!){ (data, response, err) in
            if let error = err{
                completion([],data,error)
                print(error.localizedDescription)
                return
            }
            else if let APIData = data{

            do{
                let personajes = try JSONDecoder().decode(APIPersonajesResultado.self, from: APIData)
                print("Personajes:\(personajes.data.count) ")
                print(personajes.data.results)
                completion(personajes.data.results,APIData,nil)
                DispatchQueue.main.async {
                    self.fetchedPersonajes.append(contentsOf: personajes.data.results)
                }
            }
            catch{
                completion([],data,error)
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
}
