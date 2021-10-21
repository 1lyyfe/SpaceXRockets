//
//  NetworkManager.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 19/10/2021.
//

import Foundation
import PromiseKit

enum NetworkError: String {
    case alreadyInOperation = "PROCESS_ALREADY_IN_OPERATION"
}

class NetworkManager {
        
    var session: URLSession { URLSession.shared }
    
    var baseUrl: String {
        return "https://api.spacexdata.com/v4/rockets"
    }
    
    static var `default`: NetworkManager = { // for any network setup
        let n = NetworkManager()
        return n
    }()
    
    func headers(_ additional: [String: String]?) -> [String: String] {
        var headers = additional ?? [: ]
        headers["Content-Type"] = "application/json"
        return headers
    }
    
    func request<T: Decodable>(_ objectType: T.Type, method: HTTPMethod, path: String? = nil, queries: [String: String]? = nil, body: [String: Any]? = nil, headers: [String: String]? = nil, overrideBaseUrl: String? = nil, completion: @escaping ((Swift.Result<T, Error>) -> Void)) {
        var url = URL(string: baseUrl)
        if let overrideUrl = overrideBaseUrl {
            url = URL(string: overrideUrl)
        }
        guard var url = url else {
            completion(.failure(NSError(domain: "NO_BASE_URL", code: 0, userInfo: nil)))
            return
        }
        if let path = path {
            url = url.appendingPathComponent(path)
        }
        var urlRequest = URLRequest(url: url)
        
        if let queries = queries {
            var urlComponents = URLComponents(string: url.absoluteString)
            urlComponents?.queryItems = queries.compactMap({ key, value in
                URLQueryItem(name: key, value: value)
            })
            if let urlComponents = urlComponents?.url {
                urlRequest = URLRequest(url: urlComponents)
            }
        }
        self.headers(headers).forEach({ key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        })
        
        if let body = body {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
                #if DEBUG
                print("BODY: \(String(data:jsonData, encoding: .utf8) ?? "")")
                #endif
                urlRequest.httpBody = jsonData
            } catch {
                completion(.failure(error))
                return
            }
        }
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data,
                  let response = response else {
                completion(.failure(NSError(domain: "NO_DATA_OR_RESPONSE", code: 0, userInfo: nil)))
                return
            }
            do {
                #if DEBUG
                print("RESPONSE /////////////\n \(response)")
                let jsonString = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
                print("DATA ////////////\n \(jsonString)")
                #endif
                try self.checkResponse(response)
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func checkResponse(_ response: URLResponse?) throws {
        guard let response = response as? HTTPURLResponse else {
            throw NSError(domain: "NOT_VALID_HTTP_RESPONSE", code: 400, userInfo: nil)
        }
        switch response.statusCode {
        case 200...299:
            #if DEBUG
            print(response.debugDescription)
            #endif
        default:
            throw NSError(domain: response.debugDescription, code: response.statusCode, userInfo: nil)
        }
    }
}
