//
//  HomeViewModel.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 19/10/2021.
//

import Foundation
import PromiseKit
import FeedKit

class HomeViewModel: EventObservable<HomeViewModel.Event> {
    
    enum Event {
        case networkActivity, error, rocketsUpdated
    }
    
    let service: RocketServiceProtocol
    
    var rockets = [Rocket]()
    
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
            self?.sendEvent(.rocketsUpdated)
            self?.sendEvent(.networkActivity, object: false)
        }
        .catch { [weak self] error in
            print(error.localizedDescription)
            self?.sendEvent(.error)
        }
    }
    
    func getDataAtIndex(index: Int) -> RocketSimpleDetail {
        return RocketSimpleDetail(name: rockets[index].name, image: rockets[index].images?.first, country: rockets[index].country, company: rockets[index].company, active: rockets[index].active)
    }
    
    func getRocketDetailAtIndex(index: Int) -> RocketDetailViewModel {
        return RocketDetailViewModel(name: rockets[index].name, images: rockets[index].images, country: rockets[index].country, company: rockets[index].company, active: rockets[index].active, type: rockets[index].type, stages: rockets[index].stages , boosters: rockets[index].boosters, costPerLaunch: rockets[index].costPerLaunch, pctSuccessRate: rockets[index].pctSuccessRate, firstFlight: rockets[index].firstFlight, wikipedia: rockets[index].wikipedia, description: rockets[index].description)
    }
}
