//
//  File.swift
//  Marvel
//
//  Created by macbook on 6/19/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import Foundation

protocol CharactersPresenterLogic {
    func viewDidLoad()
    func searchButtonTapped()
    
    var charactersCount: Int {get}
    
    func configure(_ cell: CharactersTableViewCellProtocol, at row: Int)
    func didSelectAt(row: Int)
}

class CharactersPresenter {
    private weak var view: CharactersViewLogic?
    private let model: CharactersModelLogic
    private var charactersArray: [CharacterResponse.Data.Results]
    private var offset = 0
    private let limit = 20
    private var isRequesting = false
    
    init(view: CharactersViewLogic, model: CharactersModelLogic, charactersArray: [CharacterResponse.Data.Results] = []) {
        self.view = view
        self.model = model
        self.charactersArray = charactersArray
    }
}

extension CharactersPresenter: CharactersPresenterLogic {
    func viewDidLoad() {
        view?.setupNaviationItems()
        getCharacters()
    }
    
    private func getCharacters() {
        guard !isRequesting else { return }
        isRequesting = true
        
        view?.showIndicator()
        model.getCharactersData(parameters: [
           "offset": offset,
           "limit": limit
        ]) { (success, response)  in
            self.isRequesting = false
            self.view?.hideIndicator()
            if success {
                self.charactersArray.append(contentsOf: response?.results ?? [])
                self.offset += self.limit
                self.view?.reloadData()
            }
        }
    }
    
    func searchButtonTapped() {
        view?.pushSearchVC()
    }
    
    var charactersCount: Int {
        return charactersArray.count
    }
    
    func configure(_ cell: CharactersTableViewCellProtocol, at row: Int) {
        cell.characterImageURL = charactersArray[row].thumbnail!.path + "." +  charactersArray[row].thumbnail!.extension
        cell.characterTitle = charactersArray[row].name
        
        if row >= offset - 1 {
            getCharacters()
        }
    }
    
    func didSelectAt(row: Int) {
        view?.navigateTCharacterDetailsVCWith(characterData: charactersArray[row])
    }
}
