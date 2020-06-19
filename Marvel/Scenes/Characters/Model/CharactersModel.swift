//
//  CharactersModel.swift
//  Marvel
//
//  Created by macbook on 6/19/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import Foundation

struct CharacterResponse: Decodable {
    let code: Int
    let data: Data?
    
    struct Data: Decodable {
        let offset: Int
        let limit: Int
        let total: Int
        let count: Int
        let results: [Results]
        
        struct Results: Decodable {
            let id: Int
            let name: String
            let description: String
            let thumbnail: Thumbnail?
            
            struct Thumbnail: Decodable {
                let path: String
                let `extension`: String
            }
        }
    }
}

protocol CharactersModelLogic {
    func getCharacters(completionHandler: @escaping (Bool, CharacterResponse.Data?) -> ())
}

class CharactersModel: CharactersModelLogic {
    func getCharacters(completionHandler: @escaping (Bool, CharacterResponse.Data?) -> ()) {
        guard let url = URL(string: BASE_URL + "characters") else {return}
        API.getDataWith(url: url) { (success, data) in
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
