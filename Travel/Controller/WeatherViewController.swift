//
//  WeatherViewController.swift
//  Travel
//
//  Created by Quentin Marlas on 16/10/2019.
//  Copyright © 2019 Quentin Marlas. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var newYorkTempLabel: UILabel!
    @IBOutlet private weak var newYorkDescriptionLabel: UILabel!
    @IBOutlet private weak var agenTempLabel: UILabel!
    @IBOutlet private weak var agenDescriptionLabel: UILabel!
    
    // MARK: - Properties
    
    private let weatherService = WeatherService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getWeather()
    }
    
    /// Function that allows to get weather description and temperature to display them on labels 
    private func getWeather() {
        weatherService.getWeather { (success, Weather) in
            if success, let weather = Weather {
                DispatchQueue.main.async {
                    self.agenTempLabel.text = String(weather.list[0].main.temp) + " °C"
                    self.agenDescriptionLabel.text = weather.list[0].weather[0].weatherDescription
                    self.newYorkTempLabel.text = String(weather.list[1].main.temp) + " °C"
                    self.newYorkDescriptionLabel.text = weather.list[1].weather[0].weatherDescription
                }
            } else {
                self.presentAlert(title: "Erreur", message: "Nous n'avons pas pu afficher la météo, veuillez réessayer")
            }
        }
    }
}
