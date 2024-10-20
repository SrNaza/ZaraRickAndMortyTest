//
//  HomeFlowRouter.swift
//  ZaraRick&MortyTest
//
//  Created by Nazareth villalba on 17/10/24.
//

import UIKit
import RxSwift
import RxCocoa

enum HomeFlowTransation {
    case showItemsSearchDetail(item: Character)
    case showItemsCollection(infoResult: [Character], presenter: HomeFlowPresenterProtocol)
}

protocol HomeFlowRouterProtocol {
    func performTransition(transition: HomeFlowTransation, onCompletion completion: RPCompletionBlock?)
    func showItemsSearchDetail(item: Character)
    func showItemsCollection(infoResult: [Character], presenter: HomeFlowPresenterProtocol)
}

// MARK: - Home Interactive Implementation
class HomeFlowRouter: HomeFlowRouterProtocol {

    // MARK: - Life Cycle
    private weak var baseController: UIViewController?
    private weak var shareModalController: UIViewController?

    init(baseController: UIViewController) {
        self.baseController = baseController
    }
    
    func performTransition(transition: HomeFlowTransation, onCompletion completion: RPCompletionBlock?) {
        switch transition {
        case .showItemsSearchDetail(let item):
            showItemsSearchDetail(item: item)
        case .showItemsCollection(let infoResult, let presenter):
            showItemsCollection(infoResult: infoResult, presenter: presenter)
        }
    }
}

extension HomeFlowRouter {
    func showItemsSearchDetail(item: Character) {
        let viewController = DetailViewController(result: item)
        baseController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showItemsCollection(infoResult: [Character], presenter: HomeFlowPresenterProtocol) {
        let viewController = ListSectionViewController(result: infoResult, presenter: presenter)
        baseController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
