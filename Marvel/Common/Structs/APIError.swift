//
//  APIError.swift
//  Marvel
//
//  Created by macbook on 6/19/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import Foundation

struct APIError: Error {
    let message: String
    var errorDescription: String? {message}
}
