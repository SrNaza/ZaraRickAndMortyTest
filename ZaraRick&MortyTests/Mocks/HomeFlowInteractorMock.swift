//
//  HomeFlowInteractorMock.swift
//  ZaraRick&Morty
//
//  Created by Nazareth villalba on 18/10/24.
//


import RxSwift
@testable import ZaraRick_Morty

class HomeFlowInteractorMock: HomeFlowInteractorProtocol {
    
    var shouldReturnError = false
    var characterResults = [Character.mock]
    var allCharactersResults = [Character.mock]
    
    func getCharacter(characterToSearch: String, page: Int) -> Single<HomeCharacterSearch> {
        if shouldReturnError {
            return Single.error(ApiError.mockError)
        } else {
            let mockSearch = HomeCharacterSearch(info: Info(count: 1, pages: 1, next: nil, prev: nil), results: characterResults)
            return Single.just(mockSearch)
        }
    }
    
    func getAllCharacterInfo(page: Int) -> Single<HomeCharacterSearch> {
        if shouldReturnError {
            return Single.error(ApiError.mockError)
        } else {
            let mockSearch = HomeCharacterSearch(info: Info(count: 1, pages: 1, next: nil, prev: nil), results: allCharactersResults)
            return Single.just(mockSearch)
        }
    }
}
