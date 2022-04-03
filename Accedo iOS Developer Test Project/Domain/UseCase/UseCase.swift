//
//  UseCase.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-01.
//

import Foundation
import Combine

protocol UseCase{
    func start() -> Future<Response?,ErrorResponse>
}
