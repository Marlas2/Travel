//
//  Exchange.swift
//  Travel
//
//  Created by Quentin Marlas on 18/09/2019.
//  Copyright © 2019 Quentin Marlas. All rights reserved.
//

import Foundation

struct Exchange: Decodable {
    let rates: [String: Float]
}
