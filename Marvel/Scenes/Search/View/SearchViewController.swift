//
//  SearchViewController.swift
//  Marvel
//
//  Created by macbook on 6/19/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import UIKit

protocol SearchViewLogic: IndicatorProtocol {
    func setupNavigationItem()
    func setupSearchController()
    func popViewController()
    func setSearchBarFirstResponder()
    func reloadData()
    func navigateTCharacterDetailsVCWith(characterData: CharacterResponse.Data.Results)
}

class SearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var presenter: SearchPresenterLogic = {
       return SearchPresenter(view: self, model: CharactersModel())
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.searchTextField.backgroundColor = .white
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.searchBar.placeholder = "Search"
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchTextDidChangedWith(text: searchText, newWord: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchBarCancelButtonDidClicked()
    }
}

extension SearchViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        presenter.didPresentSearchController()
    }
}

extension SearchViewController: SearchViewLogic {
    func setupNavigationItem() {
        navigationItem.hidesBackButton = true
        navigationItem.titleView = searchController.searchBar
    }
    
    func setupSearchController() {
        searchController.isActive = true
    }
    
    func popViewController() {
        pop()
    }
    
    func setSearchBarFirstResponder() {
        DispatchQueue.main.async {
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func navigateTCharacterDetailsVCWith(characterData: CharacterResponse.Data.Results) {
        let characterDetailsVC = returnViewControllerWith("characterDetailsVC", in: MAIN_STORYBOARD, type: CharacterDetailsViewController.self)
        characterDetailsVC.characterData = characterData
        navigationController?.pushViewController(characterDetailsVC, animated: true)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.characterCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! CharactersTableViewCell
        presenter.configure(cell, at: indexPath.row)
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectAt(row: indexPath.row)
    }
}
