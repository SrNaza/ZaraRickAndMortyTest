//
//  ZaraRick_MortyTests.swift
//  ZaraRick&MortyTests
//
//  Created by Nazareth villalba on 18/10/24.
//

import XCTest
import RxSwift
@testable import ZaraRick_Morty

class HomeFlowInteractorTests: XCTestCase {
    
    var interactor: HomeFlowInteractor!
    var apiServiceMock: ApiServiceMock!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        apiServiceMock = ApiServiceMock()
        interactor = HomeFlowInteractor(apiService: apiServiceMock)
    }
    
    override func tearDown() {
        interactor = nil
        apiServiceMock = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func testFetchAllCharactersSuccess() {
        // Simulación de llamada exitosa
        apiServiceMock.shouldReturnError = false
        
        interactor.getAllCharacterInfo(page: 1)
            .subscribe(onSuccess: { characterSearch in
                XCTAssertEqual(characterSearch.results.first?.name, "Rick Sanchez")
            }, onFailure: { error in
                XCTFail("Error no esperado")
            }).disposed(by: disposeBag)
        
        XCTAssertTrue(apiServiceMock.isFetchAllCharactersCalled)
    }
    
    func testFetchAllCharactersError() {
        // Simulación de error en la llamada
        apiServiceMock.shouldReturnError = true
        
        interactor.getAllCharacterInfo(page: 1)
            .subscribe(onSuccess: { _ in
                XCTFail("No debería haber éxito")
            }, onFailure: { error in
                XCTAssertEqual(error.localizedDescription, "Mock error")
            }).disposed(by: disposeBag)
        
        XCTAssertTrue(apiServiceMock.isFetchAllCharactersCalled)
    }
    
    func testFetchCharacterSuccess() {
        apiServiceMock.shouldReturnError = false
        
        interactor.getCharacter(characterToSearch: "Rick", page: 1)
            .subscribe(onSuccess: { characterSearch in
                XCTAssertEqual(characterSearch.results.first?.name, "Rick Sanchez")
            }, onFailure: { error in
                XCTFail("Error no esperado")
            }).disposed(by: disposeBag)
        
        XCTAssertTrue(apiServiceMock.isFetchCharacterCalled)
    }
    
    func testFetchCharacterError() {
        apiServiceMock.shouldReturnError = true
        
        interactor.getCharacter(characterToSearch: "Rick", page: 1)
            .subscribe(onSuccess: { _ in
                XCTFail("No debería haber éxito")
            }, onFailure: { error in
                XCTAssertEqual(error.localizedDescription, "Mock error")
            }).disposed(by: disposeBag)
        
        XCTAssertTrue(apiServiceMock.isFetchCharacterCalled)
    }
}
