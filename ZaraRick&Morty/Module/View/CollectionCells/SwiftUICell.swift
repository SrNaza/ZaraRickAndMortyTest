//
//  SwiftUICell.swift
//  ZaraRick&Morty
//
//  Created by Nazareth villalba on 19/10/24.
//

import SwiftUI
import UIKit

class SwiftUICell: UICollectionViewCell {
    var hostingController: UIHostingController<CharacterCellView>?

    func configure(with character: Character) {
        if let hostingController = hostingController {
            hostingController.rootView = CharacterCellView(character: character)
        } else {
            let swiftUIView = CharacterCellView(character: character)
            let hostingController = UIHostingController(rootView: swiftUIView)
            hostingController.view.backgroundColor = .clear
            self.hostingController = hostingController
            contentView.addSubview(hostingController.view)
            
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                hostingController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
                hostingController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hostingController?.view.removeFromSuperview()
        hostingController = nil
    }
}
