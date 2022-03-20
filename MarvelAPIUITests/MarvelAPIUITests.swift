//
//  MarvelAPIUITests.swift
//  MarvelAPIUITests
//
//  Created by Maximiliano Morales on 16/03/2022.
//

import XCTest

class MarvelAPIUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHomeUser() throws {
        // UI tests must launch the application that they test.
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.cells.containing(.staticText, identifier:"3-D Man").element.twoFingerTap()
        
        let marvelButton = app.navigationBars["Marvel"].buttons["Marvel"]
        marvelButton.twoFingerTap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"A-Bomb (HAS)").element/*[[".cells.containing(.staticText, identifier:\"Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction! \").element",".cells.containing(.staticText, identifier:\"A-Bomb (HAS)\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.twoFingerTap()
        marvelButton.twoFingerTap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"A.I.M.").element.swipeRight()/*[[".cells.containing(.staticText, identifier:\"AIM is a terrorist organization bent on destroying the world.\").element",".swipeUp()",".swipeRight()",".cells.containing(.staticText, identifier:\"A.I.M.\").element"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        marvelButton.twoFingerTap()
        
        
        //Podemos agregar UITest para realizar un análisis de la aplicación usando el recording una vez lanzada la APP grabando los movimientos de usuario reproduciendolo hasta encontrar un Bug.
        //Sin embargo, como tenemos 3000 llamadas a la API de Marvel por día al generar este tipo de test se llega rápido a ese número generando demora en la app.
        //Por ese motivo se agrego un test visual simples por el límite de llamadas a la API y porque se realizaron 3 aplicaciones.

    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
