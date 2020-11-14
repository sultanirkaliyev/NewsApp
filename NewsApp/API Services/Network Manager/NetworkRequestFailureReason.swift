//
//  NetworkRequestFailureReason.swift
//  NewsApp
//
//  Created by Sultan on 11/12/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation
import Alamofire

enum Result<T, U> where U: Error {
    case success(payload: T)
    case failure(U?)
}

enum NetworkRequestFailureReason: Int, Error {
    
    case badRequest = 400
    case unAuthorized = 401
    case forbidden = 403
    case notFound = 404
    case serverError = 500
    case tooManyAttempts = 429
    case parseError
    case notConnectedToInternet
    case timedOut
    case failed
    
    var heading: String {
        
        switch self {
        case .badRequest:             return "BadRequest"
        case .unAuthorized:           return "Unauthorized"
        case .forbidden:              return "Forbidden"
        case .notFound:               return "Not Found"
        case .serverError:            return "Server Error"
        case .tooManyAttempts:        return "Too Many Attempts"
        case .parseError:             return "Parse Error"
        case .notConnectedToInternet: return "Not Connected To Internet"
        case .timedOut:               return "Timed Out"
        case .failed:                 return "An unexpected error has occurred"
        }
    }
    
    var description: String {
        
        switch self {
        case .badRequest:             return "Try again"
        case .unAuthorized:           return "Try again"
        case .forbidden:              return "Try again"
        case .notFound:               return "Try again"
        case .serverError:            return "Try again"
        case .tooManyAttempts:        return "Too many requests"
        case .parseError:             return "Try again"
        case .notConnectedToInternet: return "Reboot the network and try again"
        case .timedOut:               return "Timed out request"
        case .failed:                 return "Try again"
        }
    }
}
