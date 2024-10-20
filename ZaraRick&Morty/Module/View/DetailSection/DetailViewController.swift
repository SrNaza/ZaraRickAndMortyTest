//
//  DetailViewController.swift
//  MortyApp
//
//  Created by Nazareth Villalba on 19/09/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let dotView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let dashLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "-"
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private let originLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private let lastLocationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .black
        label.text = "Last Known Location:"
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    public var item: Character = Character()
    
    init(result: Character) {
        super.init(nibName: nil, bundle: nil)
        self.item = result
        self.fill(with: item)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .lightGray
        view.addSubview(nameLabel)
        view.addSubview(imageView)
        view.addSubview(dotView)
        view.addSubview(statusLabel)
        view.addSubview(dashLabel)
        view.addSubview(speciesLabel)
        view.addSubview(genderLabel)
        view.addSubview(originLabel)
        view.addSubview(lastLocationLabel)
        view.addSubview(locationLabel)
        
        switch item.status {
        case "Alive":
            dotView.backgroundColor = .green
        case "Dead":
            dotView.backgroundColor = .red
        default:
            dotView.backgroundColor = .gray
        }
        
        setNav(icon: Images.icon(type: .backWhite), to: .leftButton, target: self, action: #selector(backButtonPressed), color: .black)
    }
    
    func fill(with character: Character) {
        imageView.contentMode = .scaleAspectFit
        imageView.donwloadImage(imageView: self.imageView, urlString: character.image)
        
        nameLabel.text = character.name
        
        statusLabel.text = character.status
        
        speciesLabel.text = character.species
        
        genderLabel.text = "Gender: \(character.gender)"
        
        originLabel.text = "Origin: \(character.origin.name)"
        
        locationLabel.text = character.location.name
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: 350)
        ])
        
        NSLayoutConstraint.activate([
            dotView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            dotView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dotView.widthAnchor.constraint(equalToConstant: 10),
            dotView.heightAnchor.constraint(equalToConstant: 10)
        ])
        
        let maxWidth: CGFloat = 150
        let statusLabelWidthConstraint = statusLabel.widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth)
        statusLabelWidthConstraint.isActive = true

        NSLayoutConstraint.activate([
            statusLabel.centerYAnchor.constraint(equalTo: dotView.centerYAnchor),
            statusLabel.leadingAnchor.constraint(equalTo: dotView.trailingAnchor, constant: 8),
            statusLabelWidthConstraint,
            statusLabel.trailingAnchor.constraint(equalTo: dashLabel.leadingAnchor, constant: -8),
        ])

        NSLayoutConstraint.activate([
            dashLabel.centerYAnchor.constraint(equalTo: dotView.centerYAnchor),
            dashLabel.leadingAnchor.constraint(equalTo: statusLabel.trailingAnchor, constant: 8),
        ])

        NSLayoutConstraint.activate([
            speciesLabel.centerYAnchor.constraint(equalTo: dotView.centerYAnchor),
            speciesLabel.leadingAnchor.constraint(equalTo: dashLabel.trailingAnchor, constant: 8),
            speciesLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            originLabel.topAnchor.constraint(equalTo: dotView.bottomAnchor, constant: 24),
            originLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            originLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            genderLabel.topAnchor.constraint(equalTo: originLabel.bottomAnchor, constant: 16),
            genderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            genderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            lastLocationLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 24),
            lastLocationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            lastLocationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: lastLocationLabel.bottomAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @objc func backButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
