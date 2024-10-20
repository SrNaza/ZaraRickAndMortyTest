//
//  NavigationControllerMock.swift
//  ZaraRick&Morty
//
//  Created by Nazareth villalba on 19/10/24.
//

import UIKit

class NavigationControllerMock: UINavigationController {
    var pushedViewController: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        print("Pushed View Controller: \(viewController)")
        super.pushViewController(viewController, animated: animated)
    }
}
