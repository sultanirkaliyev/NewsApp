//
//  NetworkErrorHandler.swift
//  NewsApp
//
//  Created by Sultan on 11/12/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation
import Moya

class NetworkErrorHandler {
    
    func handleNetworkError(_ error: Error?, _ response: Response?) -> NetworkRequestFailureReason {
        
        if let err = error as? URLError {
            
            if err.code == .notConnectedToInternet {
                return .notConnectedToInternet
            }
            
            if err.code == .timedOut {
                return .timedOut
            }
        }
        
        if let statusCode = response?.response?.statusCode, let reason = NetworkRequestFailureReason(rawValue: statusCode) {
            return reason
        }
        return .failed
    }
    
    func handleNetworkErrorByStatusCode(_ response: Response) -> NetworkRequestFailureReason {
        
        if let reason = NetworkRequestFailureReason(rawValue: response.statusCode) {
            return reason
        }
        return .failed
    }
}
