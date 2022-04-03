//
//  GenreRemoteService.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-01.
//

import Foundation

struct GenreRemoteService: GenreDataSource {
    
    
    func getGenreList(genreListArgs: GenreListArgs, completion: @escaping (GenreList?, ErrorResponse?) -> Void) {
        ///check the args if it's valid
        guard let params = genreListArgs.asDictionary() else { completion(nil, ErrorResponse(message: "args_error"))
            return
        }
       
        /// here we create the event that represent the endpoint
        let event =  API(path: EndPoints.Tmbd.movieGenre ,
                         method: .get,
                         queryParameters: params
       )
       
       ///here we call the request with our type and completion handler
       BaseNetworking.shared.request(GenreList.self,
                                             endPoint:event,completion: completion);

    }
    
}
