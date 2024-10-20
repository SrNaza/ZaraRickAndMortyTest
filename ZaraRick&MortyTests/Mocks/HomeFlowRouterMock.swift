//
//  HomeFlowRouterMock.swift
//  ZaraRick&Morty
//
//  Created by Nazareth villalba on 18/10/24.
//


import Foundation
@testable import ZaraRick_Morty

class HomeFlowRouterMock: HomeFlowRouterProtocol {
    
    var didTransitionToDetail = false
    var didTransitionToList = false
    
    func performTransition(transition: HomeFlowTransation, onCompletion completion: RPCompletionBlock?) {
        switch transition {
        case .showItemsSearchDetail:
            didTransitionToDetail = true
        case .showItemsCollection:
            didTransitionToList = true
        }
        completion?()
    }
    
    func showItemsSearchDetail(item: Character) {
        didTransitionToDetail = true
    }
    
    func showItemsCollection(infoResult: [Character], presenter: HomeFlowPresenterProtocol) {
        didTransitionToList = true
    }
}
