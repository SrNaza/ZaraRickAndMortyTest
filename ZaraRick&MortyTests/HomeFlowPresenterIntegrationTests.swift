//
//  HomeFlowPresenterIntegrationTests.swift
//  ZaraRick&Morty
//
//  Created by Nazareth villalba on 20/10/24.
//

import XCTest
import RxSwift
@testable import ZaraRick_Morty

class HomeFlowPresenterIntegrationTests: XCTestCase {
    var presenter: HomeFlowPresenter!
    var apiServiceMock: ApiServiceMock!
    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        apiServiceMock = ApiServiceMock()
        let interactor = HomeFlowInteractor(apiService: apiServiceMock)
        let router = HomeFlowRouter(baseController: UIViewController())
        presenter = HomeFlowPresenter(interactor: interactor, router: router)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        presenter = nil
        apiServiceMock = nil
        disposeBag = nil
        super.tearDown()
    }

    func testFetchAllCharactersSuccess() {
        apiServiceMock.shouldReturnError = false

        let expectation = self.expectation(description: "Success fetch characters")
        presenter.getAllCharacterInfo()
            .subscribe(onNext: { characterSearch in
                
                XCTAssertEqual(characterSearch.results.count, 1)
                XCTAssertEqual(characterSearch.results.first?.name, "Rick Sanchez")
                expectation.fulfill()
            }, onError: { _ in
                XCTFail("Expected success but got error")
            }).disposed(by: disposeBag)

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testFetchAllCharactersFailure() {
        apiServiceMock.shouldReturnError = true

        let expectation = self.expectation(description: "Error fetching characters")
        presenter.getAllCharacterInfo()
            .subscribe(onNext: { _ in
                
                XCTFail("Expected error but got success")
            }, onError: { error in
                XCTAssertEqual(error.localizedDescription, "Mock error")
                expectation.fulfill()
            }).disposed(by: disposeBag)

        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testGetCharacterSuccess() {
        // Simulación de una respuesta exitosa
        apiServiceMock.shouldReturnError = false

        let expectation = self.expectation(description: "Success fetching character")
        
        presenter.getCharacter(characterToSearch: "Rick")
            .subscribe(onNext: { characterSearch in
                XCTAssertEqual(characterSearch.results.count, 1)
                XCTAssertEqual(characterSearch.results.first?.name, "Rick Sanchez")
                expectation.fulfill()
            }, onError: { error in
                XCTFail("Error: \(error)")
            }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 2, handler: nil)
    }
}
