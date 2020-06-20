//
//  CharacterModel.swift
//  Marvel
//
//  Created by macbook on 6/20/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import Foundation

enum ActionType: String {
    case comics
    case series
    case stories
    case events
}

struct ActionsResponse: Decodable {
    let code: Int
    let data: Data?
    
    struct Data: Decodable {
        let offset: Int
        let limit: Int
        let total: Int
        let count: Int
        let results: [Results]
        
        struct Results: Decodable {
            let title: String
            let thumbnail: Thumbnail?
            
            struct Thumbnail: Decodable {
                let path: String
                let `extension`: String
            }
        }
    }
}

protocol CharacterDetailsModelLogic {
    func getActionsDataFor(characterId: Int, actionType: ActionType, completionHandler: @escaping (Bool, ActionsResponse.Data?) -> ())
}

class CharacterDetailsModel: CharacterDetailsModelLogic {
    func getActionsDataFor(characterId: Int, actionType: ActionType, completionHandler: @escaping (Bool, ActionsResponse.Data?) -> ()) {
        guard let url = URL(string: BASE_URL + "/\(characterId)" + "/\(actionType.rawValue)") else {return}
        API.getDataWith(url: url) { (success, data) in
            if success {
                let response = JSONDecoder.decode(data: data!, type: ActionsResponse.self)
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
