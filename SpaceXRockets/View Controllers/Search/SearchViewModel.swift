//
//  SearchViewModel.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 20/10/2021.
//

import Foundation
import PromiseKit
import FeedKit

class SearchViewModel: EventObservable<HomeViewModel.Event> {
    
    enum Event {
        case networkActivity, error, rocketsUpdated
    }
    
    let service: RocketServiceProtocol
    
    var rockets = [Rocket]() {
        didSet {
            if originalQuery.isEmpty {
                originalQuery = self.rockets
            }
        }
    }
    
    var originalQuery = [Rocket]()
    
    init(service: RocketServiceProtocol = RocketService()) {
        self.service = service
    }
    
    func getRockets() {
        sendEvent(.networkActivity, object: true)
        firstly {
            service.getRocketDetails()
        }
        .done { [weak self] r in
            self?.rockets.removeAll()
            self?.rockets = r
            self?.sendEvent(.rocketsUpdated, object: r.count)
            self?.sendEvent(.networkActivity, object: false)
        }
        .catch { [weak self] error in
            print(error.localizedDescription)
            self?.sendEvent(.error)
        }
    }
    
    func searchRocket(_ term: String) {
        
        if term.isEmpty {
            getRockets() //refresh when query empty is searched
            return
        }
        
        guard !self.rockets.isEmpty else { return } //error here
        
        let query = self.originalQuery.filter { c in
            guard let name = c.name else { return false }
            return (name.lowercased().contains(term.lowercased()))
        }
        
        guard !query.isEmpty else { return }
        
        self.rockets.removeAll()
        self.rockets = query
        self.sendEvent(.rocketsUpdated, object: rockets.count)
    }
    
    
    func getDataAtIndex(index: Int) -> RocketSimpleDetail {
        return RocketSimpleDetail(name: rockets[index].name, image: rockets[index].images?.first, country: rockets[index].country, company: rockets[index].company, active: rockets[index].active)
    }
    
    func getRocketDetailAtIndex(index: Int) -> RocketDetailViewModel {
        return RocketDetailViewModel(name: rockets[index].name, images: rockets[index].images, country: rockets[index].country, company: rockets[index].company, active: rockets[index].active, type: rockets[index].type, stages: rockets[index].stages , boosters: rockets[index].boosters, costPerLaunch: rockets[index].costPerLaunch, pctSuccessRate: rockets[index].pctSuccessRate, firstFlight: rockets[index].firstFlight, wikipedia: rockets[index].wikipedia, description: rockets[index].description)
    }
}
