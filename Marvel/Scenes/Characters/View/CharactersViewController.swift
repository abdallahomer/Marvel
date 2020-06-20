//
//  CharactersViewController.swift
//  Marvel
//
//  Created by macbook on 6/19/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import UIKit

protocol CharactersViewLogic: IndicatorProtocol {
    func setupNaviationItems()
    func pushSearchVC()
    func reloadData()
    func navigateTCharacterDetailsVCWith(characterData: CharacterResponse.Data.Results)
}

class CharactersViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let charactersCellIdentifier = "charactersCell"
    private lazy var presenter: CharactersPresenterLogic = {
       return CharactersPresenter(view: self, model: CharactersModel())
    }()
    
    var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.charactersCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: charactersCellIdentifier, for: indexPath) as! CharactersTableViewCell
        presenter.configure(cell, at: indexPath.row)
        
        return cell
    }
}

extension CharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectAt(row: indexPath.row)
    }
}

extension CharactersViewController: CharactersViewLogic {
    func setupNaviationItems() {
        let logoImageView = UIImageView(image: UIImage(named: "icn-nav-marvel"))
        navigationItem.titleView = logoImageView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icn-nav-search"), style: .plain, target: self, action: #selector(searchButtonTapped))
    }
    
    @objc private func searchButtonTapped() {
        presenter.searchButtonTapped()
    }
    
    func pushSearchVC() {
        pushViewControllerWith("searchVC", in: "Main")
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func navigateTCharacterDetailsVCWith(characterData: CharacterResponse.Data.Results) {
        let characterDetailsVC = returnViewControllerWith("characterDetailsVC", in: "Main", type: CharacterDetailsViewController.self)
        characterDetailsVC.characterData = characterData
        navigationController?.pushViewController(characterDetailsVC, animated: true)
    }
}
