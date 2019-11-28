//
//  Translate.swift
//  Travel
//
//  Created by Quentin Marlas on 24/10/2019.
//  Copyright © 2019 Quentin Marlas. All rights reserved.
//

import Foundation

// MARK: - Translate

struct Translate: Decodable {
    let data: DataClass
}

// MARK: - DataClass

struct DataClass: Decodable {
    let translations: [Translation]
}

// MARK: - Translation

struct Translation: Decodable {
    let translatedText: String
}

