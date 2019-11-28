//
//  ExchangeRateServiceTests.swift
//  ExchangeRateServiceTests
//
//  Created by Quentin Marlas on 23/09/2019.
//  Copyright © 2019 Quentin Marlas. All rights reserved.
//
@testable import Travel
import XCTest

class ExchangeRateServiceTests: XCTestCase {
    func testGetRateShouldPostFailedCallbackIfError() {
        // Given
        let exchangeService = ExchangeRateService(rateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getRate(currency: "USD") { (success, rate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRateShouldPostFailedCallbackIfNoData() {
        // Given
        let exchangeService = ExchangeRateService(rateSession: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getRate(currency: "USD") { (success, rate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRateShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let exchangeService = ExchangeRateService(rateSession: URLSessionFake(data: FakeResponseData.exchangeCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getRate(currency: "USD") { (success, rate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRateShouldPostFailedCallbackIfIncorrectData() {
        // Given
       let exchangeService = ExchangeRateService(rateSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getRate(currency: "USD") { (success, rate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
        func testGetRateShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
            // Given
           let exchangeService = ExchangeRateService(rateSession: URLSessionFake(data: FakeResponseData.exchangeCorrectData, response: FakeResponseData.responseOK, error: nil))
            // When
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            exchangeService.getRate(currency: "USD") { (success, rate) in
                // Then
                let result: Float = 1.10522
                XCTAssertTrue(success)
                XCTAssertNotNil(rate)
                XCTAssertEqual(result, rate)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 0.01)
        }
    
    func testGetRateShouldPostSuccessCallbackIfCallbackFalseNil() {
        
        let exchangeService = ExchangeRateService(rateSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getRate(currency: "USD") { (success, rate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetSymbolsShouldPostSuccessCallbackIfCallbackFalseNil() {
        let exchangeService = ExchangeRateService(rateSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getSymbols { (success, currencies) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(currencies)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetSymbolsShouldPostFailedCallbackIfIncorrectData() {
        // Given
       let exchangeService = ExchangeRateService(rateSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getSymbols { (success, currencies) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(currencies)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetSymbolsShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let exchangeService = ExchangeRateService(rateSession: URLSessionFake(data: FakeResponseData.exchangeCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getSymbols { (success, currencies) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(currencies)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetSymbolsShouldPostFailedCallbackIfNoData() {
        // Given
        let exchangeService = ExchangeRateService(rateSession: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getSymbols { (success, currencies) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(currencies)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetSymbolsShouldPostFailedCallbackIfError() {
        // Given
        let exchangeService = ExchangeRateService(rateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getSymbols { (success, currencies) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(currencies)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
