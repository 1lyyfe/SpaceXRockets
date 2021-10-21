//
//  Request.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 19/10/2021.
//

import Foundation
import PromiseKit

struct Request {
    let httpMethod: HTTPMethod
    let path: String
    var queries: [String: String]? = nil
    var queryItems: [URLQueryItem]? = nil
    var body: [String: Any]? = nil
    var cancelable: Bool = false
}
