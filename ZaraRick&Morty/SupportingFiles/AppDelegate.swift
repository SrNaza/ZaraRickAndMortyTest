//
//  AppDelegate.swift
//  ZaraRick&Morty
//
//  Created by Nazareth villalba on 18/10/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupView()
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.green]
        
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                UINavigationBar.appearance().barTintColor = .black
            } else {
                UINavigationBar.appearance().barTintColor = .white
            }
        } else {
            UINavigationBar.appearance().barTintColor = .white
        }
        
        return true
    }
    
    
    // MARK: - Private methods
    private func setupView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
//        let presenter: HomeFlowPresenterProtocol?
//        let router: HomeFlowRouterProtocol = HomeFlowRouter(baseController: nil)
//        let interactor: HomeFlowInteractorProtocol = HomeFlowInteractor()
//        
//        presenter = HomeFlowPresenter(interactor: interactor, router: router)
//        
//        let vc = HomeViewController(presenter: presenter)
//        let nav = CustomNavigationControllers(rootViewController: vc)
//        
//        window?.rootViewController = nav
//        window?.makeKeyAndVisible()
        
        let vc = HomeViewController()
        let nav = CustomNavigationControllers(rootViewController: vc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}

