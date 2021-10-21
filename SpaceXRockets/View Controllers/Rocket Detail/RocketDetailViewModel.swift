//
//  RocketDetailViewModel.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 20/10/2021.
//

import Foundation

struct RocketDetailViewModel {
    var name: String?
    var images: [String]?
    var country: String?
    var company: String?
    var active: Bool?
    var type: String?
    var stages: Int?
    var boosters: Int?
    var costPerLaunch: Int?
    var pctSuccessRate: Int?
    var firstFlight: String?
    var wikipedia: String?
    var description: String?
    
    func getMetaInfo() -> RocketDetailMeta {
        return RocketDetailMeta(type: self.type, stages: self.stages, boosters: self.boosters, costPerLaunch: self.costPerLaunch, pctSuccessRate: self.pctSuccessRate, firstFlight: self.firstFlight)
    }
}
