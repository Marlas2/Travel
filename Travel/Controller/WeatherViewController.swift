//
//  WeatherViewController.swift
//  Travel
//
//  Created by Quentin Marlas on 16/10/2019.
//  Copyright © 2019 Quentin Marlas. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var newYorkLabel: UILabel!
    
    @IBOutlet weak var newYorkTempLabel: UILabel!
    
    @IBOutlet weak var newYorkDescriptionLabel: UILabel!
    
    @IBOutlet weak var agenLabel: UILabel!
    
    @IBOutlet weak var agenTempLabel: UILabel!
    
    @IBOutlet weak var agenDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func didTapWeatherButton(_ sender: UIButton) {
        
    }
}
