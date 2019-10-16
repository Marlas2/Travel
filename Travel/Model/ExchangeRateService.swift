//
//  Fixer.swift
//  Travel
//
//  Created by Quentin Marlas on 18/09/2019.
//  Copyright © 2019 Quentin Marlas. All rights reserved.
//

import Foundation

class ExchangeRateService {
    
    let fixerUrl = URL(string: "http://data.fixer.io/api/latest?access_key=d595ac5936090b6eea37cd18e76aa86b&symbols=USD")
    
    var rateSession: URLSession
    var dataTask: URLSessionDataTask?
    
    init(rateSession: URLSession = URLSession(configuration: .default)) {
        self.rateSession = rateSession
    }
    
    func getRate(callback: @escaping (Bool, Float?) -> Void) {
        dataTask?.cancel()
        guard let fixerUrl = fixerUrl else { return }
        dataTask = rateSession.dataTask(with: fixerUrl) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(Exchange.self, from: data),
                    let rate = responseJSON.rates["USD"] else {
                        callback(false, nil)
                        return
                }
                callback(true, rate)
            }
        }
        dataTask?.resume()
    }
}
