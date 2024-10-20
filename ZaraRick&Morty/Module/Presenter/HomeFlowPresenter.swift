//
//  HomeFlowPresenter.swift
//  ZaraRick&MortyTest
//
//  Created by Nazareth villalba on 17/10/24.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - Home Module Presentable Implementation
public typealias RPCompletionBlock = () -> Void

enum SearchType {
    case allCharacters
    case searchCharacter(query: String)
}

class HomeFlowPresenter {
    // MARK: - Properties
    private let interactor: HomeFlowInteractorProtocol
    private let router: HomeFlowRouterProtocol
    private let disposeBag = DisposeBag()
    private var errorHandler: ((Error, ErrorContext) -> Void)?
    private var searchType: SearchType = .allCharacters
    
    private var currentPage = 1
    private var isLoading = false
    private var totalPages: Int = 0
    
    var hasMorePages: Bool {
        return currentPage <= totalPages
    }
    

    // MARK: - Life Cycle
    required init(interactor: HomeFlowInteractorProtocol, router: HomeFlowRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension HomeFlowPresenter: HomeFlowPresenterProtocol {
    func setErrorHandler(_ handler: @escaping (Error, ErrorContext) -> Void) {
        self.errorHandler = handler
    }
    
    func handleError(_ error: any Error, context: ErrorContext) {
        errorHandler?(error, context)
    }
    
    func notifyTransition(transition: HomeFlowTransation, completion: RPCompletionBlock? = nil) {
        router.performTransition(transition: transition, onCompletion: completion)
    }
    
    func getCharacter(characterToSearch: String) -> Observable<HomeCharacterSearch> {
        return interactor.getCharacter(characterToSearch: characterToSearch, page: 1)
            .do(onSuccess: { [weak self] info in
                guard let self = self else { return }
                if !info.results.isEmpty {
                    self.handleAction(.showList(item: info.results))
                }
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.handleError(error, context: .getCharacter)
            })
            .asObservable()
    }
    
    func getAllCharacterInfo() -> Observable<HomeCharacterSearch> {
        return interactor.getAllCharacterInfo(page: 1)
            .do(onSuccess: { [weak self] info in
                guard let self = self else { return }
                if !info.results.isEmpty {
                    self.handleAction(.showList(item: info.results))
                }
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.handleError(error, context: .getAllCharacters)
            })
            .asObservable()
    }
    
    func handleAction(_ action: HomePresenterAction) {
        switch action {
        case .showDetail(let item):
            router.performTransition(transition: .showItemsSearchDetail(item: item), onCompletion: nil)
        case .showList(let itemList):
            router.performTransition(transition: .showItemsCollection(infoResult: itemList, presenter: self), onCompletion: nil)
        }
    }
    
    func loadMoreCharacters() -> Observable<[Character]> {
        guard !isLoading && hasMorePages else { return Observable.just([]) }
        isLoading = true
        
        let observable: Single<HomeCharacterSearch>
        
        switch searchType {
        case .allCharacters:
            observable = interactor.getAllCharacterInfo(page: currentPage)
        case .searchCharacter(let query):
            observable = interactor.getCharacter(characterToSearch: query, page: currentPage)
        }
        
        return observable
            .do(onSuccess: { [weak self] response in
                guard let self = self else { return }
                
                self.totalPages = response.info.pages
                
                if self.currentPage >= self.totalPages {
                    self.isLoading = false
                    return
                }
                
                self.currentPage += 1
                self.isLoading = false
            }, onError: { [weak self] error in
                self?.isLoading = false
                self?.handleError(error, context: .loadMoreCharacters)
            })
            .map { $0.results }
            .asObservable()
        }
    
    func setSearchType(_ searchType: SearchType) {
        self.searchType = searchType
        self.currentPage = 1
        self.totalPages = 1
    }
}
