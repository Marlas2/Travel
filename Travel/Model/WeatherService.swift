//
//  Weather.swift
//  Travel
//
//  Created by Quentin Marlas on 07/10/2019.
//  Copyright © 2019 Quentin Marlas. All rights reserved.
//

import Foundation

final class WeatherService {
    
    let apiKey = ApiConfig.weather
    
    // MARK: - Properties
    
    private var weatherSession: URLSession
    private var dataTask: URLSessionDataTask?
    
    init(weatherSession: URLSession = URLSession(configuration: .default)) {
        self.weatherSession = weatherSession
    }
    
    /// Send a request to the API "OpenWeatherMap" and callback the response
    func getWeather(callback: @escaping (Bool, Weather?) -> Void) {
        let weatherUrl = URL(string: "http://api.openweathermap.org/data/2.5/group?APPID=\(apiKey)&id=3038633,5128581&units=metric")
        dataTask?.cancel()
        guard let url = weatherUrl else { return }
        dataTask = weatherSession.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                callback(false, nil)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(false, nil)
                return
            }
            guard let responseJSON = try? JSONDecoder().decode(Weather.self, from: data) else {
                callback(false, nil)
                return
            }
            callback(true, responseJSON)
        }
        dataTask?.resume()
    }
}
