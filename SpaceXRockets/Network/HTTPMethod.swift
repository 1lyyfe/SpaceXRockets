//
//  HTTPMethod.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 19/10/2021.
//


import Foundation
import UIKit

public enum HTTPMethod: String, CaseIterable {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}
