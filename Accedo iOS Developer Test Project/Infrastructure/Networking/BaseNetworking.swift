//
//  BaseNetworking.swift
//  Accedo iOS Developer Test Project
//
//  Created by Abu Umair Jihan on 2022-04-01.
//

import Foundation
import Alamofire
import Combine

// MARK: - Generic base networking class that will send request to the server and parse the response
class BaseNetworking {
    
    // MARK: Shared Instance
    public static let shared: BaseNetworking = BaseNetworking()
    
    
    ///To handle API calls and return the response
    func request<T: Codable>(_ t: T.Type,endPoint: API, completion: @escaping (_ result: T?, _ error: ErrorResponse?) -> Void)  {
        
        guard let url = buildRequestURL(endPoint: endPoint) else {
            completion(nil, ErrorResponse(message: "invalid_url"))
            return
        }
        
        let request = URLRequest(url: url)
        let cachedResponse = URLCache.shared.cachedResponse(for: request)
        
        if(cachedResponse == nil) || (cachedResponse?.userInfo?["requestTime"] as? Date)?.iSPassed24Hours ?? true {
            URLCache.shared.removeCachedResponse(for: request)
            AF.request(url, method: endPoint.method, parameters: endPoint.bodyParamaters, encoding: endPoint.bodyEncoding, headers: endPoint.headerParamaters )
                .validate().responseDecodable(of: T.self) { (response) in
                    switch response.result {
                    case .success(_):
                        guard let responseObj = response.value else
                        {
                            completion(nil, ErrorResponse(message: "parsing_error"))
                            return
                        }
                        print(responseObj)
                        let cachedURLResponse = CachedURLResponse(response: response.response!, data: response.data! as Data , userInfo: ["requestTime": Date()], storagePolicy: .allowed)
                        URLCache.shared.storeCachedResponse(cachedURLResponse, for: request)
                        completion(responseObj, nil)
                        
                    case .failure(_):
                        completion(nil, ErrorResponse(message: "server_error"))
                    }
                }
        }else{
            let decoder = JSONDecoder()
            do {
                if let data = cachedResponse?.data {
                    let responseObj = try decoder.decode(T.self, from: data)
                    completion(responseObj, nil)
                }else{
                    completion(nil, ErrorResponse(message: "parsing_error"))
                }
            } catch {
                completion(nil, ErrorResponse(message: "parsing_error"))
            }
        }
        
    }
    
    
    /// in order to handle the get request with any query parameters
    private func buildRequestURL(endPoint: API) -> URL? {
        
        let queryDictionary = endPoint.queryParameters
        
        let env = AppEnvironment.current
        
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = env.baseURL
        components.path = endPoint.path
        
        components.queryItems = queryDictionary.map {
            URLQueryItem(name: $0, value: "\($1)")
        }
        
        return components.url
    }
    
}

