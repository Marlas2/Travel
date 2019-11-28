//
//  ExchangeRateViewController.swift
//  Travel
//
//  Created by Quentin Marlas on 18/09/2019.
//  Copyright © 2019 Quentin Marlas. All rights reserved.
//

import UIKit

final class ExchangeRateViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var convertedSumLabel: UILabel!
    @IBOutlet private weak var ratesPickerView: UIPickerView!
    @IBOutlet private weak var sumTextField: UITextField!
    @IBOutlet private weak var rateActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var convertButton: UIButton!
    
    // MARK: - Properties
    
    private let exchangeRateService = ExchangeRateService()
    private var allRates = [String]()
    /// This is the currency convertion
    private var currency = "AED"
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ratesPickerView.dataSource = self
        ratesPickerView.delegate = self
        exchangeRateService.getSymbols { (success, symbols) in
            if success, let symbols = symbols {
                DispatchQueue.main.async {
                    self.allRates = symbols
                    self.ratesPickerView.reloadAllComponents()
                }
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        sumTextField.resignFirstResponder()
    }
    
    /// Action to convert all money in euros when you tap the "Convert" button
    @IBAction private func didTapConvertButton(_ sender: UIButton) {
        toggleActivityIndicator(shown: true)
        guard let sumText = sumTextField.text else { return }
        guard let money = Float(sumText) else { return }
        exchangeRateService.getRate(currency: currency) { (success, rate) in
            if success, let rate = rate {
                DispatchQueue.main.async {
                    self.sumTextField.resignFirstResponder()
                    let currencies = (money * rate)
                    self.convertedSumLabel.text = "\(self.currency) : \(currencies)"
                }
            } else {
                self.presentAlert(title: "Erreur", message: "Impossible de convertir")
            }
        }
        update(shown: true)
    }
    
    /// Function that allows to stop the activity indicator's animation
    private func update(shown: Bool) {
        convertButton.isHidden = !shown
        rateActivityIndicator.stopAnimating()
    }
    
    /// Function that allows to start the activity indicator's animation
    private func toggleActivityIndicator(shown: Bool) {
        convertButton.isHidden = shown
        rateActivityIndicator.startAnimating()
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension ExchangeRateViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allRates.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return allRates[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currency = allRates[row]
    }
}


