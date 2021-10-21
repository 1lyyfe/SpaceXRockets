//
//  HomeViewModelTests.swift
//  SpaceXRocketsTests
//
//  Created by Haider Ashfaq on 20/10/2021.
//

import Foundation
import XCTest
import PromiseKit
@testable import SpaceXRockets

class HomeViewModelTests: XCTestCase {
    
    var sut: HomeViewModel!
    
    let rocket1 = Rocket(id: "id1", name: "Rocket 1", type: "Rocket", active: true, stages: 3, boosters: 3, costPerLaunch: 100, pctSuccessRate: 10, firstFlight: "2001", country: "UK", company: "Test Company", wikipedia: nil, description: "This is a test rocket", images: nil)
    
    let rocket2 = Rocket(id: "id2", name: "Rocket 2", type: "UFO", active: true, stages: 3, boosters: 3, costPerLaunch: 100, pctSuccessRate: 10, firstFlight: "3033", country: "Who knows?", company: "??", wikipedia: nil, description: "This is a test UFO", images: nil)

    override func setUp() {
        super.setUp()
        sut = HomeViewModel()
        sut.rockets = [rocket1, rocket2]
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testGetDataAtIndex() {
        let r = sut.getDataAtIndex(index: 0)
        XCTAssertEqual(r.name, "Rocket 1")
        XCTAssertEqual(r.image, nil)
        
        let r2 = sut.getDataAtIndex(index: 1)
        XCTAssertEqual(r2.name, "Rocket 2")
        XCTAssertEqual(r2.image, nil)
    }
    
    //TO DO - Test all properties and functionality of view model
    //TO DO - Add MockService to stub api fetch
    //TO DO - Add Snapshot testing
    //TO DO - Add UI Tests
}
