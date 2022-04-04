//
//  ErrorResponse.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-01.
//

import Foundation

struct ErrorResponse: Encodable, Error {

    let message: String
    
    init(message: String) {
        self.message = message
    }
    
}
