//
//  CharacterDetailsPresenter.swift
//  Marvel
//
//  Created by macbook on 6/20/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import Foundation

protocol CharacterDetailsPresenterLogic {
    func viewDidLoad()
    
    var cellCount: Int {get}
    
    func configure(_ cell: CharacterThumbnailCellProtocol, at row: Int)
    func configure(_ cell: CharacterDetailsCellProtocol, at row: Int)
    func configure(_ cell: CharacterActionsCell, at row: Int)
    func configure(_ cell: CharacterRelatedLinksCell, at row: Int)
}

class CharacterDetailsPresenter {
    private weak var view: CharacterDetailsViewLogic?
    private let model: CharacterDetailsModelLogic
    
    init(view: CharacterDetailsViewLogic, model: CharacterDetailsModelLogic) {
        self.view = view
        self.model = model
    }
}

extension CharacterDetailsPresenter: CharacterDetailsPresenterLogic {
    func viewDidLoad() {
        view?.setCharacterTitle()
        view?.setupNaviationItems()
    }
    
    var cellCount: Int {
        return 4
    }
    
    func configure(_ cell: CharacterThumbnailCellProtocol, at row: Int) {
        guard let characterImageURL = view?.characterImageURL else {return}
        cell.thumbnailImageURL = characterImageURL.path + "." + characterImageURL.extension
    }
    
    func configure(_ cell: CharacterDetailsCellProtocol, at row: Int) {
        if let characterName = view?.characterName { cell.nameTitle = characterName }
        if let description = view?.characterDescription {
            cell.characterDescription = description
        } else {
            cell.characterDescription = "Not available"
        }
    }
    
    func configure(_ cell: CharacterActionsCell, at row: Int) {
        
    }
    
    func configure(_ cell: CharacterRelatedLinksCell, at row: Int) {
        guard let linkTitlesArray = view?.characterLinks else {return}
        for link in linkTitlesArray {
            let stackView = view?.configureLinksStackViewsWith(title: link.type)
            cell.stackView = stackView
        }
    }
}
