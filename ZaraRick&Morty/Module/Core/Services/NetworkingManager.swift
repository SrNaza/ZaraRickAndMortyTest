//
//  NetworkingManager.swift
//  ZaraRick&MortyTest
//
//  Created by Nazareth villalba on 17/10/24.
//

import Foundation

let baseURL = "https://rickandmortyapi.com/api"

struct ApiError: Decodable, Error {
    let message: String
}

enum ErrorContext {
    case getAllCharacters
    case getCharacter
    case loadMoreCharacters
}

public class Api {
    
    required init() {}
    
    func formatterUrl(characterToSearch: String, page: Int? = nil) -> String {
        var path: String = "\(baseURL)/character/?name=\(characterToSearch)"
        
        if let validText = characterToSearch.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[] ").inverted) {
            path = "\(baseURL)/character/?name=\(validText)"
        }
        
        // Agregar el número de página después de asegurar el nombre del personaje
        if let validPage = page {
            path.append("&page=\(validPage)")
        }

        return path
    }

    
    func urlAllCharacters(page: Int? = nil) -> String {
        var path = "\(baseURL)/character"
        
        if let validPage = page {
            path.append("?page=\(validPage)")
        }
        
        return path
        
    }
}
