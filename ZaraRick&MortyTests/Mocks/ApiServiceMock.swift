//
//  ApiServiceMock.swift
//  ZaraRick&Morty
//
//  Created by Nazareth villalba on 18/10/24.
//


import RxSwift
import Foundation

@testable import ZaraRick_Morty

class ApiServiceMock: ApiServiceProtocol {
    var isFetchCharacterCalled = false
    var isFetchAllCharactersCalled = false
    var shouldReturnError = false
    
    public init() {}
    
    func fetchCharacter(characterToSearch: String, page: Int?) -> Single<HomeCharacterSearch> {
        isFetchCharacterCalled = true
        print("FetchCharacter called in mock")
        if shouldReturnError {
            return Single.error(ApiError.mockError)
        } else {
            let mockCharacterSearch = HomeCharacterSearch(info: Info(count: 1, pages: 1, next: nil, prev: nil), results: [Character.mock])
            return Single.just(mockCharacterSearch)
        }
    }
    
    func fetchAllCharacters(page: Int = 1) -> Single<HomeCharacterSearch> {
        isFetchAllCharactersCalled = true
        print("FetchAllCharacters called in mock")
        if shouldReturnError {
            return Single.error(ApiError.mockError)
        } else {
            let mockCharacterSearch = HomeCharacterSearch(info: Info(count: 1, pages: 1, next: nil, prev: nil), results: [Character.mock])
            return Single.just(mockCharacterSearch)
        }
    }
}

// Extensiones para crear mocks
extension Character {
    static var mock: Character {
        return Character(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: Location(name: "Earth", url: ""),
            location: Location(name: "Earth", url: ""),
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            episode: [],
            url: "",
            created: ""
        )
    }
}

extension ApiError {
    static var mockError: Error {
        return NSError(domain: "mock.error", code: 400, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
    }
}
