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
}

class CharactersPresenter {
    private weak var view: CharactersViewLogic?
    private let model: CharactersModelLogic!
    
    init(view: CharactersViewLogic, model: CharactersModelLogic) {
        self.view = view
        self.model = model
    }
}

extension CharactersPresenter: CharactersPresenterLogic {
    func viewDidLoad() {
        
    }
}
