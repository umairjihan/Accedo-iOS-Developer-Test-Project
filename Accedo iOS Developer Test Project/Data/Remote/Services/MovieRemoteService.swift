//
//  MovieRemoteService.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-02.
//

import Foundation

struct MovieRemoteService: MovieDataSource {
    
    
    func getMovieList( movieListArgs: MovieListArgs, completion: @escaping (_ result: MovieList?, _ error: ErrorResponse?) -> Void) {
        ///check the args if it's valid
        guard let params = movieListArgs.asDictionary() else { completion(nil, ErrorResponse(message: "args_error"))
            return
        }
       
        /// here we create the event that represent the endpoint
        let event =  API(path: EndPoints.Tmbd.discoverMovie ,
                         method: .get,
                         queryParameters: params
       )
       
       ///here we call the request with our type and completion handler
       BaseNetworking.shared.request(MovieList.self,
                                             endPoint:event,completion: completion);

    }
    
}
