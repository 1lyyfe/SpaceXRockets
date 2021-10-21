//
//  RocketService.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 19/10/2021.
//

import Foundation
import PromiseKit

protocol RocketServiceProtocol {
    func getRocketDetails() -> Promise<[Rocket]>
}

class RocketService: RocketServiceProtocol {
    
    public func getRocketDetails() -> Promise<[Rocket]> {
  
        return Promise() { resolver in
            NetworkManager.default.request([Rocket].self, method: .get, completion: { response in
                switch(response) {
                case .success(let rockets):
                    resolver.fulfill(rockets)
                case .failure(let error):
                    resolver.reject(error)
                }
            })
        }
    }
}
