//  Created by Quentin Marlas on 23/09/2019.
//  Copyright © 2019 Quentin Marlas. All rights reserved.
//
@testable import Travel
import XCTest

final class WeatherServiceTests: XCTestCase {
    
    func testGetWeatherShouldPostFailedCallbackIfError() {
        // Given
        let weather = WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weather.getWeather() { (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        // Given
        let weather = WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weather.getWeather { (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let weather = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.exchangeCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weather.getWeather { (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let weather = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weather.getWeather { (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let weather = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weather.getWeather { (success, weather) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(weather)
            XCTAssertEqual(weather?.list[0].main.temp, 292.28)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostSuccessCallbackIfCallbackFalseNil() {
        // Given
        let weather = WeatherService(weatherSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weather.getWeather { (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
