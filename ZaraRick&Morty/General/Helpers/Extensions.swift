//
//  Extensions.swift
//  ZaraRick&Morty
//
//  Created by Nazareth villalba on 18/10/24.
//

import UIKit
import SDWebImage

// MARK: - UIViewController
extension UIViewController {
    enum ButtonDirections {
        case leftButton
        case rightButton
    }
    
    func setNav(icon: UIImage?, to button: ButtonDirections, target: Any?, action: Selector?, color: UIColor = .white, font: UIFont? = nil, and title: String = "", speacing addSpacing: Double = 0) {
        
        let barButton = UIBarButtonItem(image: icon, style: .plain, target: target, action: action)
        
        switch button {
        case .leftButton:
            navigationItem.leftBarButtonItem = barButton
            navigationItem.leftBarButtonItem?.tintColor = color
            navigationItem.leftBarButtonItem?.title = title
            
            
            
            if let font = font {
                navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: font, .foregroundColor: color], for: .normal)
                navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: font, .foregroundColor: color], for: .highlighted)
                navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: font, .foregroundColor: color], for: .selected)
            }
            
            navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.kern: addSpacing], for: .normal)
            navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.kern: addSpacing], for: .highlighted)
            navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.kern: addSpacing], for: .selected)
            break
        default:
            navigationItem.rightBarButtonItem = barButton
            navigationItem.rightBarButtonItem?.tintColor = color
            navigationItem.rightBarButtonItem?.title = title
            if let font = font {
                navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: font, .foregroundColor: color], for: .normal)
                navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: font, .foregroundColor: color], for: .highlighted)
                navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: font, .foregroundColor: color], for: .selected)
            }
            
            navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.kern: addSpacing], for: .normal)
            navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.kern: addSpacing], for: .highlighted)
            navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.kern: addSpacing], for: .selected)
            break
        }
        

    }
    
    func showOptionsAlert(title: String?, redButtonTitle: String, message: String, cancelBlock: @escaping() -> Void) {
        let refreshAlert = UIAlertController(
            title: title ?? "",
            message: message,
            preferredStyle: .alert
        )
        
        refreshAlert.addAction(UIAlertAction(title: redButtonTitle, style: .destructive, handler: { _ in
            cancelBlock()
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func showErrorAlert(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension UITextField{
    func setPlaceHolderColor() {
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
    }
}

extension UIImageView {
    func donwloadImage(imageView: UIImageView, urlString: String) {
        guard let url = URL(string: urlString) else {
            imageView.image = Images.image(type: .placeholderImage)
            return
        }
        
        imageView.sd_setImage(with: url, placeholderImage: Images.image(type: .placeholderImage), completed: { (image, error, cacheType, imageUrl) in
            if error == nil {
                imageView.image = image
            } else {
                imageView.image = Images.image(type: .placeholderImage)
            }
        })
    }
}

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

