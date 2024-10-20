//
//  HomeFlowPresenterProtocol.swift
//  ZaraRick&MortyTest
//
//  Created by Nazareth villalba on 17/10/24.
//

import RxSwift
import RxCocoa

protocol HomeFlowPresenterProtocol {
    func getCharacter(characterToSearch: String) -> Observable<HomeCharacterSearch>
    func getAllCharacterInfo() -> Observable<HomeCharacterSearch>
    func notifyTransition(transition: HomeFlowTransation, completion: RPCompletionBlock?)
    func handleAction(_ action: HomePresenterAction)
    func loadMoreCharacters() -> Observable<[Character]>
    func setErrorHandler(_ handler: @escaping (Error, ErrorContext) -> Void)
    func handleError(_ error: Error, context: ErrorContext)
    func setSearchType(_ searchType: SearchType)
    var hasMorePages: Bool { get }
}

enum HomePresenterAction {
    case showDetail(item: Character)
    case showList(item: [Character])
}
