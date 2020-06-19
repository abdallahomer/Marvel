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
    var charactersCount: Int {get}
    func configure(_ cell: CharactersTableViewCellLogic, at row: Int)
    func didSelectAt(row: Int)
}

class CharactersPresenter {
    private weak var view: CharactersViewLogic?
    private let model: CharactersModelLogic!
    private var charctersArray: [CharacterResponse.Data.Results]
    
    init(view: CharactersViewLogic, model: CharactersModelLogic, charctersArray: [CharacterResponse.Data.Results] = []) {
        self.view = view
        self.model = model
        self.charctersArray = charctersArray
    }
}

extension CharactersPresenter: CharactersPresenterLogic {
    func viewDidLoad() {
        getCharacters()
    }
    
    private func getCharacters() {
        view?.showIndicator()
        model.getCharacters { (success, response)  in
            self.view?.hideIndicator()
            if success {
                self.charctersArray = response?.results ?? []
                self.view?.reloadData()
            }
        }
    }
    
    var charactersCount: Int {
        return charctersArray.count
    }
    
    func configure(_ cell: CharactersTableViewCellLogic, at row: Int) {
        cell.characterImageURL = charctersArray[row].thumbnail!.path + charctersArray[row].thumbnail!.extension
        cell.characterTitle = charctersArray[row].name
    }
    
    func didSelectAt(row: Int) {
        
    }
}
