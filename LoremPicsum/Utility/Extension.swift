//
//  Extension.swift
//  Oddsium
//
//  Created by Ansal Antony on 11/06/22.
//

import Foundation
import UIKit


// MARK: - alert View
extension UIViewController {
    
    func  alertPresent(title: String, message: String) {
        let alert = UIAlertController(title:title, message:message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: ConstantsLocaleKeys.ok, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIView {
    
    func dropShadow() {
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.masksToBounds = false
        
    }
}



