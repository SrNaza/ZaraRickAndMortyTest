//
//  HomeFlowPresenterTests.swift
//  ZaraRick&Morty
//
//  Created by Nazareth villalba on 18/10/24.
//


import XCTest
import RxSwift
@testable import ZaraRick_Morty

class HomeFlowPresenterTests: XCTestCase {
    
    var presenter: HomeFlowPresenter!
    var interactorMock: HomeFlowInteractorMock!
    var routerMock: HomeFlowRouterMock!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        interactorMock = HomeFlowInteractorMock()
        routerMock = HomeFlowRouterMock()
        presenter = HomeFlowPresenter(interactor: interactorMock, router: routerMock)
    }
    
    override func tearDown() {
        presenter = nil
        interactorMock = nil
        routerMock = nil
        disposeBag = nil
        super.tearDown()
    }
    
    // Test para obtener todos los personajes
    func testGetAllCharactersSuccess() {
        presenter.getAllCharacterInfo()
            .subscribe(onNext: { characterSearch in
                XCTAssertEqual(characterSearch.results.first?.name, "Rick Sanchez")
            }, onError: { error in
                XCTFail("Error no esperado")
            }).disposed(by: disposeBag)
        
        XCTAssertTrue(routerMock.didTransitionToList)
    }
    
    // Test para obtener un personaje en específico
    func testGetCharacterSuccess() {
        presenter.setSearchType(.searchCharacter(query: "Rick"))
        
        presenter.getCharacter(characterToSearch: "Rick")
            .subscribe(onNext: { characterSearch in
                XCTAssertEqual(characterSearch.results.first?.name, "Rick Sanchez")
            }, onError: { error in
                XCTFail("Error no esperado")
            }).disposed(by: disposeBag)
        
        XCTAssertTrue(routerMock.didTransitionToList)
    }
    
    // Test de transición a la vista de detalle
    func testShowDetailTransition() {
        presenter.handleAction(.showDetail(item: Character.mock))
        
        XCTAssertTrue(routerMock.didTransitionToDetail)
    }
    
    // Test de manejo de errores
    func testHandleError() {
        var errorHandled = false
        
        presenter.setErrorHandler { error, context in
            XCTAssertEqual(error.localizedDescription, "Mock error")
            XCTAssertEqual(context, .getAllCharacters)
            errorHandled = true
        }
        
        interactorMock.shouldReturnError = true
        
        presenter.getAllCharacterInfo()
            .subscribe(onNext: { _ in
                XCTFail("No debería haber éxito")
            }).disposed(by: disposeBag)
        
        XCTAssertTrue(errorHandled)
    }
}
