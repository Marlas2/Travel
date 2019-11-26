//
//  Fixer.swift
//  Travel
//
//  Created by Quentin Marlas on 18/09/2019.
//  Copyright © 2019 Quentin Marlas. All rights reserved.
//

import Foundation

final class ExchangeRateService {
    
    let apiKey = ApiKeysExtractor().apiKey.exchange
    
    // MARK: - Properties
    
    var rateSession: URLSession
    var dataTask: URLSessionDataTask?
    
    init(rateSession: URLSession = URLSession(configuration: .default)) {
        self.rateSession = rateSession
    }
    
    /// Permet d'envoyer une requête à l'API "fixer.io" et renvoie sa réponse
    func getRate(currency: String, callback: @escaping (Bool, Float?) -> Void) {
        let fixerUrl = URL(string: "http://data.fixer.io/api/latest?access_key=\(apiKey)&symbols=\(currency)")
        dataTask?.cancel()
        guard let url = fixerUrl else { return }
        dataTask = rateSession.dataTask(with: url) { (data, response, error) in
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
                    let rate = responseJSON.rates[currency] else {
                        callback(false, nil)
                        return
                }
                callback(true, rate)
            }
        }
        dataTask?.resume()
    }
    
    func getSymbols(callback: @escaping (Bool, [String]?) -> Void) {
        let fixerUrl = URL(string: "http://data.fixer.io/api/symbols?access_key=d595ac5936090b6eea37cd18e76aa86b")
        dataTask?.cancel()
        guard let url = fixerUrl else { return }
        dataTask = rateSession.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(Symbols.self, from: data) else {
                    callback(false, nil)
                    return
                }
                var currencies = [String]()
                responseJSON.symbols.forEach { (key, value) in
                    currencies.append(key)
                }
                    
                callback(true, currencies.sorted(by: <))
            }
        }
        dataTask?.resume()
    }
}
