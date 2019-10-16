//
//  Weather.swift
//  Travel
//
//  Created by Quentin Marlas on 07/10/2019.
//  Copyright © 2019 Quentin Marlas. All rights reserved.
//

import Foundation

class WeatherService {
    let weatherUrl = URL(string: "http://api.openweathermap.org/data/2.5/group?APPID=c4fc39e59162af554c59dcd027407898&id=3038633,5128581")
       
       var weatherSession: URLSession
       var dataTask: URLSessionDataTask?
       
       init(weatherSession: URLSession = URLSession(configuration: .default)) {
           self.weatherSession = weatherSession
       }
       
       func getWeather(callback: @escaping (Bool, Weather?) -> Void) {
           dataTask?.cancel()
           guard let weatherUrl = weatherUrl else { return }
           dataTask = weatherSession.dataTask(with: weatherUrl) { (data, response, error) in
               DispatchQueue.main.async {
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
           }
           dataTask?.resume()
       }
}
