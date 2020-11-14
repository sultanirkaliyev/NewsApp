//
//  DefaultAlamofireSessionManager.swift
//  NewsApp
//
//  Created by Sultan on 11/12/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation
import Alamofire

class DefaultAlamofireSessionManager: SessionManager {
    static let shared: DefaultAlamofireSessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireSessionManager(configuration: configuration)
    }()
}
