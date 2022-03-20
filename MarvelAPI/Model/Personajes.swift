//
//  Personajes.swift
//  MarvelAPI
//
//  Created by Maximiliano Morales on 17/03/2022.
//

import Foundation

struct APIPersonajesResultado: Codable {
    var data: APIPersonajes
}

struct APIPersonajes: Codable {
    var count: Int
    var results: [Personajes]
}

struct Personajes: Identifiable,Codable {
    var id: Int
    var name: String
    var description: String
    var thumbnail: [String: String]
    var urls: [[String: String]]
}

struct ErrorModel : Codable {
    let code : String?
    let message : String?
}
