//
//  AuthTokenService.swift
//  NewsApp
//
//  Created by Sultan on 11/13/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation

class AuthTokenService {
    private init() {}
    static let shared = AuthTokenService()
}

extension AuthTokenService {
    
    func getToken() -> String {
        return "b4b7b111015147ae87e5053272f33fbd"
    }
}
