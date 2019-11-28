
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weather = try? newJSONDecoder().decode(Weather.self, from: jsonData)

import Foundation

// MARK: - Weather

struct Weather: Decodable {
    let list: [List]
}

// MARK: - List

struct List: Decodable {
    let weather: [WeatherElement]
    let main: Main
}

// MARK: - Main

struct Main: Decodable {
    let temp: Double
}

// MARK: - WeatherElement

struct WeatherElement: Decodable {
    let main, weatherDescription: String

    enum CodingKeys: String, CodingKey {
        case main
        case weatherDescription = "description"
    }
}
