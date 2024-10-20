//
//  ApiService.swift
//  ZaraRick&MortyTest
//
//  Created by Nazareth villalba on 17/10/24.
//

import RxSwift
import Alamofire
import Foundation

protocol ApiServiceProtocol {
    func fetchCharacter(characterToSearch: String, page: Int?) -> Single<HomeCharacterSearch>
    func fetchAllCharacters(page: Int) -> Single<HomeCharacterSearch>
}

class ApiService: ApiServiceProtocol {
    
    static let shared = ApiService()
    private init() {}
    
    private func handleError(_ dataResponse: Data?, defaultError: AFError) -> Error {
        if let data = dataResponse,
           let apiError = try? JSONDecoder().decode(ApiError.self, from: data) {
            return apiError
        }
        return defaultError
    }
    
    func fetchCharacter(characterToSearch: String, page: Int?) -> Single<HomeCharacterSearch> {
        let url = Api().formatterUrl(characterToSearch: characterToSearch, page: page)
        
        return Single<HomeCharacterSearch>.create { single in
            AF.request(url).responseDecodable(of: HomeCharacterSearch.self) { response in
                switch response.result {
                case .success(let result):
                    single(.success(result))
                case .failure(let error):
                    let finalError = self.handleError(response.data, defaultError: error)
                    single(.failure(finalError))
                }
            }
            return Disposables.create()
        }
    }
    
    func fetchAllCharacters(page: Int = 1) -> Single<HomeCharacterSearch> {
        let url = Api().urlAllCharacters(page: page)
        
        return Single<HomeCharacterSearch>.create { single in
            AF.request(url).responseDecodable(of: HomeCharacterSearch.self) { response in
                switch response.result {
                case .success(let result):
                    single(.success(result))
                case .failure(let error):
                    let finalError = self.handleError(response.data, defaultError: error)
                    single(.failure(finalError))
                }
            }
            return Disposables.create()
        }
    }
}
