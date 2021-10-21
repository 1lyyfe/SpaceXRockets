//
//  Rocket.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 19/10/2021.
//

import Foundation

public struct Rocket: Codable {
    // MARK: Properties
    public var id: String?
    public var name: String?
    public var type: String?
    public var active: Bool?
    public var stages: Int?
    public var boosters: Int?
    public var costPerLaunch: Int?
    public var pctSuccessRate: Int?
    public var firstFlight: String?
    public var country: String?
    public var company: String?
    public var wikipedia: String?
    public var description: String?
    public var images: [String]?
}

extension Rocket {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case type = "type"
        case active = "active"
        case stages = "stages"
        case costPerLaunch = "cost_per_launch"
        case pctSuccessRate = "success_rate_pct"
        case firstFlight = "first_flight"
        case company = "company"
        case country = "country"
        case wikipedia = "wikipedia"
        case description = "description"
        case images = "flickr_images"
    }
}
