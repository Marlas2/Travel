//
//  ExchangeRateViewController.swift
//  Travel
//
//  Created by Quentin Marlas on 18/09/2019.
//  Copyright © 2019 Quentin Marlas. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController {
    
    @IBOutlet weak var convertedSumLabel: UILabel!
    
    @IBOutlet weak var moneySegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var sumTextField: UITextField!
    
    @IBOutlet weak var convertButton: UIButton!
    let exchangeRateService = ExchangeRateService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        sumTextField.resignFirstResponder()
        
    }
    
    @IBAction func didTapConvertButton(_ sender: UIButton) {
        toggleActivityIndicator(shown: true)
        let money = Float(sumTextField.text!)!
        
        exchangeRateService.getRate { (succes, rate) in
            
            if self.moneySegmentedControl.selectedSegmentIndex == 0 && succes, let rate = rate {
                let dollars = Float(money * rate)
                self.convertedSumLabel.text = "$\(dollars)"
            } else {
                self.presentAlert()
            }
        }
        
    }
    
    func update(rate: Exchange) {
        
    }
    
    func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "Cannot convert", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok !", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    func toggleActivityIndicator(shown: Bool) {
        convertButton.isHidden = shown
        // rateActivityIndicator.isHidden = !shown
    }
}

