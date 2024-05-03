//
//  SportaYaTests.swift
//  SportaYaTests
//
//  Created by A7med Fekry on 25/04/2024.
//

import XCTest
@testable import SportaYa

final class SportaYaTests: XCTestCase {

    var fetchInstance: Fetch!

       override func setUpWithError() throws {
           fetchInstance = Fetch()
       }

       override func tearDownWithError() throws {
           fetchInstance = nil
       }
       
       func testFetchLeagues() {
           let expectation = XCTestExpectation(description: "Fetch Leagues")
           
           fetchInstance.fetchLeagues(sport: "football") { result in
               switch result {
               case .success(let leagues):
                   XCTAssertTrue(((leagues.result?.isEmpty) != nil), "Leagues should not be empty")
               case .failure(let error):
                   XCTFail("Failed to fetch leagues with error: \(error.localizedDescription)")
               }
               expectation.fulfill()
           }
           
           wait(for: [expectation], timeout: 20.0)
       }
       
       func testFetchTennisPlayers() {
           let expectation = XCTestExpectation(description: "Fetch Tennis Players")
           
           fetchInstance.fetchTennisPlayers(sport: "tennis") { result in
               switch result {
               case .success(let players):
                   XCTAssertTrue(((players.result?.isEmpty) != nil), "Players should not be empty")
               case .failure(let error):
                   XCTFail("Failed to fetch tennis players with error: \(error.localizedDescription)")
               }
               expectation.fulfill()
           }
           
           wait(for: [expectation], timeout: 10.0)
       }
       
    func testFetchTennisFixtures() {
        let expectation = XCTestExpectation(description: "Fetch Tennis Fixtures")
        
        fetchInstance.fetchTennisFixtures(sport: "tennis") { result in
            switch result {
            case .success(let fixtures):
                XCTAssertTrue(((fixtures.result?.isEmpty) != nil), "Fixtures should not be empty")
            case .failure(let error):
                XCTFail("Failed to fetch tennis fixtures with error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }

    func testFetchTeams() {
        let expectation = XCTestExpectation(description: "Fetch Teams")
        
        fetchInstance.fetchTeams(sport: "football", leagueId: 1) { result in
            switch result {
            case .success(let teams):
                XCTAssertTrue(((teams.result?.isEmpty) != nil), "Teams should not be empty")
            case .failure(let error):
                XCTFail("Failed to fetch teams with error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }

    func testFetchLeagueFixtures() {
        let expectation = XCTestExpectation(description: "Fetch League Fixtures")
        
        fetchInstance.fetchLeagueFixtures(leagueID: 1, sport: "football") { result in
            switch result {
            case .success(let fixtures):
                XCTAssertFalse(((fixtures.result?.isEmpty) != nil), "League fixtures should not be empty")
            case .failure(let error):
                XCTFail("Failed to fetch league fixtures with error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }

    func testFetchLeagueStandings() {
        let expectation = XCTestExpectation(description: "Fetch League Standings")
        
        fetchInstance.fetchLeagueStandings(leagueID: 1, sport: "football") { result in
            switch result {
            case .success(let standings):
                XCTAssertFalse(((standings.result?.isEmpty) != nil), "League standings should not be empty")
            case .failure(let error):
                XCTFail("Failed to fetch league standings with error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
}
