//
//  CharacterDetailsPresenter.swift
//  Marvel
//
//  Created by macbook on 6/20/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import UIKit

protocol CharacterDetailsPresenterLogic {
    func viewDidLoad()
    
    var TableViewCellCount: Int {get}
    
    func configure(_ cell: CharacterThumbnailCellProtocol, at row: Int)
    func configure(_ cell: CharacterDetailsCellProtocol, at row: Int)
    func configure(_ cell: CharacterActionsCell, at row: Int)
    func configure(_ cell: CharacterRelatedLinksCell, at row: Int)
    
    func tableViewWillDisplayAt(_ cell: CharacterActionsCell, at row: Int)
    func tableViewDidEndDisplayingAt(_ cell: CharacterActionsCell, at row: Int)
    
    var actions: [[ActionsResponse.Data.Results]] {get}
    func configure(_ cell: ActionCollectionViewCellProtocol, at parentRow: Int, childRow: Int)
    func didSelectAt(parentRow: Int, childRow: Int)
}

class CharacterDetailsPresenter {
    private weak var view: CharacterDetailsViewLogic?
    private let model: CharacterDetailsModelLogic
    private var actionsArray = [[ActionsResponse.Data.Results]]()
    private let actionsTitlesArray = ["COMICS", "SERIES", "STORIES", "EVENTS"]
    private var storedOffsets = [Int: CGFloat]()
    
    init(view: CharacterDetailsViewLogic, model: CharacterDetailsModelLogic) {
        self.view = view
        self.model = model
    }
}

extension CharacterDetailsPresenter: CharacterDetailsPresenterLogic {
    func viewDidLoad() {
        view?.setCharacterTitle()
        view?.setupPresentation()
        view?.setupNaviationItems()
        self.actionsArray = [[], [], [], []]
        getActionsfor(actionType: .comics) { self.actionsArray[0] = $0 }
        getActionsfor(actionType: .series) { self.actionsArray[1] = $0 }
        getActionsfor(actionType: .stories) { self.actionsArray[2] = $0 }
        getActionsfor(actionType: .events) { self.actionsArray[3] = $0 }
    }
    
    private func getActionsfor(actionType: ActionType, completion: @escaping ([ActionsResponse.Data.Results]) -> Void) {
        view?.showIndicator()
        guard let characterId = view?.characterId else {return}
        model.getActionsDataFor(characterId: characterId, actionType: actionType) { (success, response) in
            self.view?.hideIndicator()
            if success {
                completion(response?.results ?? [])
                self.view?.reloadData()
            }
        }
    }
    
    var TableViewCellCount: Int {
        actionsTitlesArray.count
    }
    
    func configure(_ cell: CharacterThumbnailCellProtocol, at row: Int) {
        guard let characterImageURL = view?.characterImageURL else {return}
        cell.thumbnailImageURL = characterImageURL.path + "." + characterImageURL.extension
    }
    
    func configure(_ cell: CharacterDetailsCellProtocol, at row: Int) {
        if let characterName = view?.characterName { cell.nameTitle = characterName }
        if let description = view?.characterDescription, !description.isEmpty {
            cell.characterDescription = description
        } else {
            cell.characterDescription = "Not available"
        }
    }
    
    func configure(_ cell: CharacterActionsCell, at row: Int) {
        cell.actionTitleLabel.text = actionsTitlesArray[row]
    }
    
    func configure(_ cell: CharacterRelatedLinksCell, at row: Int) {
        guard let linkTitlesArray = view?.characterLinks else {return}
        let linkViews = linkTitlesArray.compactMap({ view?.configureLinksStackViewsWith(title: $0.type) })
        cell.set(linkViews: linkViews)
    }
    
    func tableViewWillDisplayAt(_ cell: CharacterActionsCell, at row: Int) {
        cell.collectionViewOffset = storedOffsets[row] ?? 0
    }
    
    func tableViewDidEndDisplayingAt(_ cell: CharacterActionsCell, at row: Int) {
        storedOffsets[row] = cell.collectionViewOffset
    }
    
    var actions: [[ActionsResponse.Data.Results]] {
        actionsArray
    }
    
    func configure(_ cell: ActionCollectionViewCellProtocol, at parentRow: Int, childRow: Int) {
        let path = actionsArray[safe: parentRow]?[childRow].thumbnail?.path ?? ""
        let `extension` = actionsArray[safe: parentRow]?[childRow].thumbnail?.extension ?? ""
        cell.actionImageURL = path + "." + `extension`
        cell.actionTitle = actionsArray[safe: parentRow]?[childRow].title ?? ""
    }
    
    func didSelectAt(parentRow: Int, childRow: Int) {
        view?.presentMediaDataWith(data: actionsArray[parentRow][childRow])
    }
}
