//
//  CharactersModel.swift
//  Marvel
//
//  Created by macbook on 6/19/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import Foundation

protocol CharactersModelLogic {
    func getCharactersData(parameters: [String: String], completionHandler: @escaping (Bool, CharacterResponse.Data?) -> ())
}

class CharactersModel: CharactersModelLogic {
    func getCharactersData(parameters: [String: String], completionHandler: @escaping (Bool, CharacterResponse.Data?) -> ()) {
        guard let url = URL(string: BASE_URL + "characters") else {return}
        API.getDataWith(url: url, parameters) { (success, data) in
            if success {
                if success {
                    let response = JSONDecoder.decode(data: data!, type: CharacterResponse.self)
                    if response.code == SUCCESS_STATUS {
                        completionHandler(true, response.data!)
                    } else {
                        completionHandler(false, nil)
                    }
                } else {
                    completionHandler(false, nil)
                }
            }
        }
    }
}
