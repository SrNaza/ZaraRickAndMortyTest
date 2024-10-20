//
//  ListSectionViewController.swift
//  MortyApp
//
//  Created by Nazareth Villalba on 19/09/23.
//

import UIKit
import RxSwift
import SwiftUI

class ListSectionViewController: UIViewController {

    @IBOutlet var collection: UICollectionView!

    internal var result: [Character] = []
    internal var presenter: HomeFlowPresenterProtocol
    private var activityIndicator: UIActivityIndicatorView!
    private let disposeBag = DisposeBag()

    init(result: [Character], presenter: HomeFlowPresenterProtocol) {
        self.result = result
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collection.register(SwiftUICell.self, forCellWithReuseIdentifier: "SwiftUICell")
        setup()
        setupActivityIndicator()
    }
}

private extension ListSectionViewController {
    func setup() {
        setNav(icon: Images.icon(type: .backWhite), to: .leftButton, target: self, action: #selector(backButtonPressed), color: .black)
        collection.delegate = self
        collection.dataSource = self
    }

    @objc func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(activityIndicator)
    }

    private func showLoading(_ show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}

extension ListSectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SwiftUICell", for: indexPath) as? SwiftUICell else {
            return UICollectionViewCell()
        }

        let character = result[indexPath.row]
        cell.configure(with: character)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.handleAction(.showDetail(item: result[indexPath.row]))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2   //number of column you want
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: 330)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        
        if position > (contentHeight - scrollViewHeight - 100) && presenter.hasMorePages {
            showLoading(true)
            
            presenter.loadMoreCharacters()
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: { [weak self] newCharacters in
                    guard let self = self else { return }
                    
                    let filteredCharacters = newCharacters.filter { !self.result.contains($0) }
                    
                    let startIndex = self.result.count
                    let endIndex = startIndex + filteredCharacters.count
                    
                    self.result.append(contentsOf: filteredCharacters)
                    
                    let indexPaths = (startIndex..<endIndex).map { IndexPath(item: $0, section: 0) }
                    
                    // Actualizar solo las nuevas celdas
                    self.collection.performBatchUpdates({
                        self.collection.insertItems(at: indexPaths)
                    }, completion: nil)
                    
                    self.showLoading(false)
                }, onError: { [weak self] error in
                    guard let self = self else { return }
                    self.showLoading(false)
                    self.showErrorAlert(error: error)
                }).disposed(by: disposeBag)
        }
    }
}
