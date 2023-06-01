//
//  HomeViewModelTests.swift
//  WerddTests
//
//  Created by Hannie Kim on 5/30/23.
//

import XCTest
@testable import Werdd

final class HomeViewModelTests: XCTestCase {

    var sut: HomeViewModel!
    
    override func setUp() {
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager._fetchRandomWord = Word(word: "Hello", results: [])
        sut = HomeViewModel(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        sut = nil
    }

    func testRefreshRandomWordSuccess() async {
        do {
            try await sut.refreshRandomWord()
            XCTAssertEqual(sut.randomWordTitle, "Happy")
            XCTAssertNil(sut.randomWordDefinition)
        } catch {
            XCTFail("Expected a successful refresh request")
        }
    }
    
    func testRefreshRandomWordWithDetails() {
        let mockNetworkManager = MockNetworkManager()
        mockNetworkManager._fetchRandomWord = Word(word: "Hello", results: [])
        let sut = HomeViewModel(networkManager: mockNetworkManager)
        
        
    }
}
