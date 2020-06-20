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
    
    func configure(_ cell: CharactersTableViewCellLogic, at row: Int)
    func didSelectAt(row: Int)
}

class CharactersPresenter {
    private weak var view: CharactersViewLogic?
    private let model: CharactersModelLogic
    private var charactersArray: [CharacterResponse.Data.Results]
    
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
        view?.showIndicator()
        model.getCharactersData(parameters: [:]) { (success, response)  in
            self.view?.hideIndicator()
            if success {
                self.charactersArray = response?.results ?? []
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
    
    func configure(_ cell: CharactersTableViewCellLogic, at row: Int) {
        cell.characterImageURL = charactersArray[row].thumbnail!.path + "." +  charactersArray[row].thumbnail!.extension
        cell.characterTitle = charactersArray[row].name
    }
    
    func didSelectAt(row: Int) {
        
    }
}
