//
//  Untitled.swift
//  ZaraRick&MortyTest
//
//  Created by Nazareth villalba on 17/10/24.
//

import RxSwift
import RxCocoa
import Alamofire

protocol HomeFlowInteractorProtocol {
    func getCharacter(characterToSearch: String, page: Int) -> Single<HomeCharacterSearch>
    func getAllCharacterInfo(page: Int) -> Single<HomeCharacterSearch>
}

// MARK: - Home Interactive Implementation
class HomeFlowInteractor: HomeFlowInteractorProtocol {
    
    private let apiService: ApiServiceProtocol
        
    init(apiService: ApiServiceProtocol = ApiService.shared) {
        self.apiService = apiService
    }
    
    func getCharacter(characterToSearch: String, page: Int) -> Single<HomeCharacterSearch> {
        return apiService.fetchCharacter(characterToSearch: characterToSearch, page: page)
    }
    
    func getAllCharacterInfo(page: Int) -> Single<HomeCharacterSearch> {
        return apiService.fetchAllCharacters(page: page)
    }
}
