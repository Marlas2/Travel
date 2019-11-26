//
//  TranslateViewController.swift
//  Travel
//
//  Created by Quentin Marlas on 24/10/2019.
//  Copyright © 2019 Quentin Marlas. All rights reserved.
//

import UIKit

final class TranslateViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var frenchTextField: UITextField!
    
    @IBOutlet private weak var englishTextField: UITextField!
    
    // MARK: - Properties
    
    private let translateService = TranslateService()
    
    // MARK: - Actions
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
            frenchTextField.resignFirstResponder()
            englishTextField.resignFirstResponder()
    }
    
    @IBAction private func didTapTranslateButton(_ sender: UIButton) {
        guard let text = frenchTextField.text else {
            return
        }
        translateService.getTranslate(source: "fr", target: "en", text: text) { (success, translate) in
            
            if success, let translate = translate {
                self.frenchTextField.resignFirstResponder()
                self.englishTextField.resignFirstResponder()
                self.englishTextField.text = String(translate.data.translations[0].translatedText)
            } else {
                self.presentAlert(title: "Error", message: "Nous n'avons pas pu traduire !")
            }
        }
    }
}
