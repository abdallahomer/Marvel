//
//  SearchPresenter.swift
//  Marvel
//
//  Created by macbook on 6/19/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

protocol SearchPresenterLogic {
    func viewDidLoad()
    func viewDidAppear()
    func searchBarCancelButtonDidClicked()
    func searchTextDidChangedWith(text: String)
    func didPresentSearchController()
    
    var characterCount: Int {get}
    
    func configure(_ cell: CharactersTableViewCellProtocol, at row: Int)
    func didSelectAt(row: Int)
}

class SearchPresenter {
    private weak var view: SearchViewLogic?
    private let model: CharactersModelLogic
    private var charactersArray: [CharacterResponse.Data.Results]
    private var offset = 0
    private let limit = 20
    private var isRequesting = false
    private var searchText = String()
    
    init(view: SearchViewLogic, model: CharactersModelLogic, charactersArray: [CharacterResponse.Data.Results] = []) {
        self.view = view
        self.model = model
        self.charactersArray = charactersArray
    }
}

extension SearchPresenter: SearchPresenterLogic {
    func viewDidLoad() {
        view?.setupNavigationItem()
    }
    
    func viewDidAppear() {
        view?.setupSearchController()
    }
    
    func searchBarCancelButtonDidClicked() {
        view?.popViewController()
    }
    
    func didPresentSearchController() {
        view?.setSearchBarFirstResponder()
    }
    
    func searchTextDidChangedWith(text: String) {
        guard !isRequesting else { return }
        isRequesting = true
        
        guard checkIfTextNotEmpty(text: text) else {return}
        searchText = text
        let parameters: [String: Any] = [
            "nameStartsWith": text,
           "offset": offset,
           "limit": limit
        ]
        view?.showIndicator()
        model.getCharactersData(parameters: parameters) { (success, response) in
            self.view?.hideIndicator()
            if success {
                self.isRequesting = false
                self.charactersArray.append(contentsOf: response?.results ?? [])
                self.offset += self.limit
                self.view?.reloadData()
            }
        }
    }
    
    private func checkIfTextNotEmpty(text: String) -> Bool {
        guard !text.isEmpty else {
            charactersArray.removeAll()
            view?.reloadData()
            return false
        }
        
        return true
    }
    
    var characterCount: Int {
        return charactersArray.count
    }
    
    func configure(_ cell: CharactersTableViewCellProtocol, at row: Int) {
        cell.characterImageURL = charactersArray[row].thumbnail!.path + "." +  charactersArray[row].thumbnail!.extension
        cell.characterTitle = charactersArray[row].name
        
        if row >= offset - 1 {
            searchTextDidChangedWith(text: searchText)
        }
    }
    
    func didSelectAt(row: Int) {
        view?.navigateTCharacterDetailsVCWith(characterData: charactersArray[row])
    }
}
