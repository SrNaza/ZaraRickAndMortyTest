//
//  Constans.swift
//  ZaraRick&MortyTest
//
//  Created by Nazareth villalba on 17/10/24.
//

import UIKit

// MARK: - Images
struct Images {
    enum icons: String {
        case buttonContinue = "button.continue.active"
        case logout = "logout"
        case menu = "menu"
        case user = "user"
        case backWhite = "backWhite"
    }
    
    enum images: String {
        case login = "LOGIN"
        case placeholderImage = "placeholderImage"
        case logo = "logotipo"
        case logo2 = "logo2"
    }
    
    enum tabBarIcons: String {
        case home = "home"
        case favorites = "favorito"
    }
    
    static func icon(type: icons) -> UIImage? {
        return UIImage(named: "\(type.rawValue)")
    }
    
    static func image(type: images) -> UIImage? {
        return UIImage(named: "\(type.rawValue)")
    }
    
    static func tabBarIcon(type: tabBarIcons) -> UIImage? {
        return UIImage(named: "\(type.rawValue)")
    }
}
