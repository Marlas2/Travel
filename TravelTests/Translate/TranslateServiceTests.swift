//  Created by Quentin Marlas on 23/09/2019.
//  Copyright © 2019 Quentin Marlas. All rights reserved.
//
@testable import Travel
import XCTest

class TranslateServiceTests: XCTestCase {
    
    func testGetTranslateShouldPostFailedCallbackIfError() {
        // Given
        let translate = TranslateService(translateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translate.getTranslate(source: "FR" , target: "EN", text: "J'ai gagné") { (success, translate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfNoData() {
        // Given
        let translate = TranslateService(translateSession: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translate.getTranslate(source: "FR" , target: "EN", text: "J'ai gagné") { (success, translate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let translate = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.exchangeCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translate.getTranslate(source: "FR" , target: "EN", text: "J'ai gagné") { (success, translate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let translate = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translate.getTranslate(source: "FR" , target: "EN", text: "J'ai gagné") { (success, translate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let translate = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translate.getTranslate(source: "FR" , target: "EN", text: "J'ai gagné") { (success, translate) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldPostSuccessCallbackIfCallbackFalseNil() {
        let translate = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translate.getTranslate(source: "FR" , target: "EN", text: "Bonjour le monde") { (success, translate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslateShouldPostSuccesCallbackIfTranslationIsNotNil() {
        let translate = TranslateService(translateSession: URLSessionFake(data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translate.getTranslate(source: "FR" , target: "EN", text: "Bonjour le monde") { (success, translate) in
            // Then
            let translation = "Bonjour le monde"
            XCTAssertTrue(success)
            XCTAssertNotNil(translate)
            XCTAssertEqual(translation, translate?.data.translations[0].translatedText)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}

