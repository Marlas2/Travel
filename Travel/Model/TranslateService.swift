//
//  TranslateService.swift
//  Travel
//
//  Created by Quentin Marlas on 24/10/2019.
//  Copyright © 2019 Quentin Marlas. All rights reserved.
//

import Foundation

class TranslateService {
    
    // MARK: - Properties
    
    var translateSession: URLSession
    var dataTask: URLSessionDataTask?
    
    init(translateSession: URLSession = URLSession(configuration: .default)) {
        self.translateSession = translateSession
    }
    
    /// Permet d'envoyer une requête à l'API "Google Translate" et renvoie sa réponse
    func getTranslate(source: String, target: String, text: String, callback: @escaping (Bool, Translate?) -> Void) {
        dataTask?.cancel()
        guard let textEncoded = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else  { return }
        
        let translateUrl = URL(string: "https://translation.googleapis.com/language/translate/v2?key=AIzaSyAGi9-JNMsVYpkZIGBGElrHmDtGHzMNFzQ&target=\(target)&q=\(textEncoded)&source=\(source)")
        guard let url = translateUrl else { return }
        dataTask = translateSession.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(Translate.self, from: data) else {
                    callback(false, nil)
                    return
                }
                callback(true, responseJSON)
            }
        }
        dataTask?.resume()
    }
}

