//
//  API.swift
//  Marvel
//
//  Created by macbook on 6/19/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import Foundation
import Alamofire

class API {
    static func getDataWith(url: URL, _ parameters: [String: Any] = [:], completionHandler: @escaping(Bool, Data?) -> ()){
        var parameters = parameters
        let timestamp = String(Date().timeIntervalSince1970)
        
        parameters["apikey"] = PUBLIC_KEY
        parameters["hash"] = "\(timestamp)\(PRIVATE_KEY)\(PUBLIC_KEY)".md5()
        parameters["ts"] = timestamp
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .success( let value):
                completionHandler(true, response.data!)
                break
            case .failure (let error):
                completionHandler(false, nil)
                break
            }
        }
    }
}
