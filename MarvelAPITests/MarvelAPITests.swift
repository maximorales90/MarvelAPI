//
//  MarvelAPITests.swift
//  MarvelAPITests
//
//  Created by Maximiliano Morales on 16/03/2022.
//

import XCTest
import CryptoKit
@testable import MarvelAPI

class MarvelAPITests: XCTestCase {

    var testModel : APIPersonajesResultado?
    var errorModel : ErrorModel?

    private var privateKey = "4a713e705a83dfb7feebb80f8390cdfd7b085ff5"
    private var publicKey = "62e163c483a7ebc127ae82380ee69b15"
    private var baseURL = "https://gateway.marvel.com:443/v1/public/"

    
    
    //MARK: Test API Lista de Personajes cuando es Empty String y retorna Error
    func testPersonajesWithEmptyStringReturnsError() {
        let expectation = self.expectation(description: "emptyString")
        let url = "\(baseURL)characters?ts=&apikey=&hash="
        APIManager.init().fetchPersonajes(urltest: url, testActive: true, completion: { personajesData, jsonData, error in
            let jsonDecoder = JSONDecoder()
            self.errorModel = try? jsonDecoder.decode(ErrorModel.self, from: jsonData!)
            XCTAssertEqual(self.errorModel?.message, "La API Key no es valida.")
            XCTAssertEqual(self.errorModel?.code, "FallaCredenciales")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //MARK: Test API Lista de Personajes con parametros Hash Invalidos y retorna Error
    func testPersonajesWithInvalidHashParametersReturnsError() {
        let expectation = self.expectation(description: "invalidHash")
        let url = "\(baseURL)characters?ts=22222&apikey=asdasldjlakjfqakhdqdq344r"
        APIManager.init().fetchPersonajes(urltest: url, testActive: true, completion: { personajesData, jsonData, error in
            let jsonDecoder = JSONDecoder()
            self.errorModel = try? jsonDecoder.decode(ErrorModel.self, from: jsonData!)
            XCTAssertEqual(self.errorModel?.message, "La API Key no es valida.")
            XCTAssertEqual(self.errorModel?.code, "FallaCredenciales")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //MARK: Test API Lista de Personajes sin TimeStamp y retorna Error
    func testPersonajesWithMissingtsReturnsError() {
        let expectation = self.expectation(description: "missedTimeStamp")
        let ts = String(Int(Date().timeIntervalSinceNow))
        let hash = MD5(data: "\(ts)\(privateKey)\(publicKey)")
        let url = "\(baseURL)characters?apikey=\(publicKey)&hash=\(hash)"
        APIManager.init().fetchPersonajes(urltest: url, testActive: true, completion: { personajesData, jsonData, error in
            let jsonDecoder = JSONDecoder()
            self.errorModel = try? jsonDecoder.decode(ErrorModel.self, from: jsonData!)
            XCTAssertEqual(self.errorModel?.message, "Debe proporcionar un TimeStamp.")
            XCTAssertEqual(self.errorModel?.code, "FaltaParametro")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    //MARK: Test API Lista de Personajes con parametros validos y respuesta correcta
    func testPersonajesWithvalidHashParametersReturnsCorrectResponse() {
        let expectation = self.expectation(description: "validParametes")
        let ts = String(Int(Date().timeIntervalSinceNow))
        
        let hash = MD5(data:"\(ts)\(privateKey)\(publicKey)")
        let url = "\(baseURL)characters?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        APIManager.init().fetchPersonajes(urltest: url, testActive: true, completion: { personajesData, jsonData, error in
            let jsonDecoder = JSONDecoder()
            self.testModel = try? jsonDecoder.decode(APIPersonajesResultado.self, from: jsonData!)
            XCTAssertNotNil(self.testModel?.data.results)
            XCTAssertEqual(self.testModel?.status, "Ok")
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
    func MD5(data: String)->String{
        
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        return hash.map{
            String(format: "%02hhx", $0)
        }
        .joined()
    }

}
