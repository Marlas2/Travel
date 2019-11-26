//
//  ApiKeys.swift
//  Travel
//
//  Created by Quentin Marlas on 08/11/2019.
//  Copyright © 2019 Quentin Marlas. All rights reserved.
//

import Foundation

final class ApiKeysExtractor {
    var apiKey: ApiKey {
        guard let path = Bundle.main.path(forResource: "Apikeys", ofType: "plist"), let data = FileManager.default.contents(atPath: path) else {
            fatalError("Can't find Apikeys.plist")
        }
        guard let dataExtracted = try? PropertyListDecoder().decode(ApiKey.self, from: data) else {
            fatalError("Can't decode Apikey.plist")
        }
        return dataExtracted
    }
}

struct ApiKey: Decodable {
    let weather: String
    let exchange: String
    let translate: String
}
