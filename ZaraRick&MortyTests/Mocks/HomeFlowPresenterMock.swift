//
//  HomeFlowPresenterMock.swift
//  ZaraRick&Morty
//
//  Created by Nazareth villalba on 19/10/24.
//

import RxSwift

@testable import ZaraRick_Morty
class HomeFlowPresenterMock: HomeFlowPresenterProtocol {
    var getCharacterCalled = false
    var getAllCharacterInfoCalled = false
    
    func getCharacter(characterToSearch: String) -> Observable<HomeCharacterSearch> {
        getCharacterCalled = true
        return Observable.just(HomeCharacterSearch.mock())
    }
    
    func getAllCharacterInfo() -> Observable<HomeCharacterSearch> {
        getAllCharacterInfoCalled = true
        return Observable.just(HomeCharacterSearch.mock())
    }
    
    func notifyTransition(transition: HomeFlowTransation, completion: RPCompletionBlock?) { }
    func handleAction(_ action: HomePresenterAction) { }
    func loadMoreCharacters() -> Observable<[Character]> { return Observable.just([]) }
    func setErrorHandler(_ handler: @escaping (Error, ErrorContext) -> Void) { }
    func handleError(_ error: Error, context: ErrorContext) { }
    func setSearchType(_ searchType: SearchType) { }
    var hasMorePages: Bool { return true }
}

extension HomeCharacterSearch {
    static func mock() -> HomeCharacterSearch {
        return HomeCharacterSearch(info: Info(count: 10, pages: 1, next: nil, prev: nil), results: [Character.mock])
    }
}


