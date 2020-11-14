//
//  NewsFeedDataService.swift
//  NewsApp
//
//  Created by Sultan on 11/13/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation
import Moya
import PromiseKit

class NewsFeedDataService {
    
    //MARK: - Request Typealias
    
    typealias RequestArticlesResult = Result<[Article], NetworkRequestFailureReason>
    
    //MARK: - Token
    
    static let tokenClosure: () -> String = {
        return AuthTokenService.shared.getToken()
    }
    
    static let authPlugin = AccessTokenPlugin(tokenClosure: tokenClosure)
    
    //MARK: - Network Error Handler
    
    fileprivate let networkErrorHandler = NetworkErrorHandler()
    
    //MARK: - Provider
    
    fileprivate let provider = MoyaProvider<NewsFeedService>(endpointClosure: { (target: NewsFeedService) -> Endpoint in
        let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
        switch target {
        default:
            let httpHeaderFields = ["Accept": "application/json"]
            return defaultEndpoint.adding(newHTTPHeaderFields: httpHeaderFields)
        }
    }, manager: DefaultAlamofireSessionManager.shared, plugins: [authPlugin, NetworkLoggerPlugin(verbose: false)])
}

//MARK: - Network Requests

extension NewsFeedDataService {
    
    func getArticles(endPoint: TypeOfNewsFeedEndPoint, page: Int, category: String?, q: String?, qInTitle: String?) -> Promise<RequestArticlesResult> {
        
        return Promise<RequestArticlesResult> { seal in
            
            provider.request(.getArticles(endPoint: endPoint, page: page, category: category, q: q, qInTitle: qInTitle)) { (response) in
                
                switch response {
                case .success(let result):
                    
                    do {
                        let serverJSON = try JSONDecoder().decode(ServerResponseArticles.self, from: result.data)
                        
                        if let articles = serverJSON.articles {
                            seal.fulfill(.success(payload: articles))
                        } else {
                            seal.reject(NetworkRequestFailureReason.parseError)
                        }
                    } catch let error {
                        print(error)
                        seal.reject(NetworkRequestFailureReason.parseError)
                    }
                    
                case .failure(let error):
                    
                    switch error {
                    case .statusCode(let statusCode):
                        seal.reject(self.networkErrorHandler.handleNetworkErrorByStatusCode(statusCode))
                    case .underlying(let error, let response):
                        seal.reject(self.networkErrorHandler.handleNetworkError(error, response))
                    default:
                        seal.reject(NetworkRequestFailureReason.failed)
                    }
                }
            }
        }
    }    
}
