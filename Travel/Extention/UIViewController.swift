//
//  AlertExtention.swift
//  Travel
//
//  Created by Quentin Marlas on 08/11/2019.
//  Copyright © 2019 Quentin Marlas. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok !", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}



