//
//  HomeViewController.swift
//  ZaraRick&MortyTest
//
//  Created by Nazareth villalba on 17/10/24.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {

    // MARK: - Initialization
    @IBOutlet weak var searchBardField: UITextField! {
        didSet {
            searchBardField.rx.controlEvent([.editingDidEndOnExit])
                .subscribe(onNext: { [weak self] in
                    guard let self = self else { return }
                    self.sendInformation()
                }).disposed(by: disposeBag)
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.image = Images.image(type: .logo)
        }
    }
    
    @IBOutlet weak var seeAllCharacterButton: UIButton!
    
    var presenter: HomeFlowPresenterProtocol?
    private var activityIndicator: UIActivityIndicatorView!
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let interactor: HomeFlowInteractorProtocol = HomeFlowInteractor()
        let router: HomeFlowRouterProtocol = HomeFlowRouter(baseController: self)
        presenter = HomeFlowPresenter(interactor: interactor, router: router)
        setHerrorHandle()
        setupActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    
    @IBAction func seeAllCharacterAction(_ sender: Any) {
        guard let presenter = presenter else { return }
        
        showLoading(true)
        
        presenter.setSearchType(.allCharacters)

        let detailInfo = presenter.getAllCharacterInfo().asObservable()

        detailInfo.asObservable()
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.showLoading(false)
            }, onError: { [weak self] _ in
                guard let self = self else { return }
                self.showLoading(false)
            }).disposed(by: disposeBag)
    }
}

extension HomeViewController {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchBardField.resignFirstResponder()
        return true
    }
    
    func setup() {
        searchBardField.text = ""
        searchBardField.textColor = .black
        searchBardField.placeholder = "Search Rick and Morty Character"
        searchBardField.setPlaceHolderColor()
        
        titleLabel.text = "Rick & Morty App 🫡"
        titleLabel.textColor = .white
        
        seeAllCharacterButton.backgroundColor = UIColor.white
        seeAllCharacterButton.layer.cornerRadius = 8.0
        
        imageView.layer.cornerRadius = 80.0 // Puedes ajustar este valor a tu preferencia
        imageView.layer.masksToBounds = true
        
        presenter?.setSearchType(.allCharacters)
    }
    
    func sendInformation() {
        guard let presenter = presenter else { return }

        if searchBardField.text?.count == 0 {
            searchBardField.text = ""
            searchBardField.placeholder = "Search Rick and Morty Character"
            showOptionsAlert(title: "Empty Search", redButtonTitle: "Cancel", message: "You need to indicate an character to search for") { }
        }
        
        showLoading(true)
        
        presenter.setSearchType(.searchCharacter(query: searchBardField.text ?? ""))
        
        presenter.getCharacter(characterToSearch: searchBardField.text ?? "")
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.showLoading(false)
            }, onError: { [weak self] _ in
                guard let self = self else { return }
                self.showLoading(false)
            }).disposed(by: disposeBag)
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
    
    func setHerrorHandle() {
        presenter?.setErrorHandler { [weak self] error, context in
            guard let self = self else { return }

            let errorMessage: String

            switch context {
            case .getAllCharacters:
                errorMessage = "Failed to load characters. Please try again."
            case .getCharacter:
                errorMessage = "Failed to find the character. Please Ensure to indicate a valid character to search for and without special characters."
            case .loadMoreCharacters:
                errorMessage = "Failed to find the more characters. Please try again."
            }

            if let apiError = error as? ApiError {
                self.showOptionsAlert(title: "Error", redButtonTitle: "OK", message: apiError.message) {
                }
            } else {
                self.showOptionsAlert(title: "Error", redButtonTitle: "OK", message: errorMessage) { }
            }
        }
    }
}
