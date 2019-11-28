//
//  FakeResponseExchangeData.swift
//  ExchangeRateServiceTests
//
//  Created by Quentin Marlas on 23/09/2019.
//  Copyright © 2019 Quentin Marlas. All rights reserved.
//

import Foundation

final class FakeResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class ExchangeError: Error {}
    static let error = ExchangeError()
    static var exchangeCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Exchange", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static var translateCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let incorrectData = "erreur".data(using: .utf8)!
}
