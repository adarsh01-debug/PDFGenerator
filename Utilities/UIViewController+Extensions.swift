//
//  UIViewController+Extensions.swift
//  PDFReportGenerator-UIKit
//
//  Created by Adarsh on 31/05/25.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, actionTitle: String?, style: UIAlertAction.Style = .default, preferredStyle: UIAlertController.Style = .alert, handler: ((UIAlertAction) -> Void)? = nil) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: preferredStyle
            )
            
            alert.addAction(UIAlertAction(title: actionTitle ?? "OK", style: style, handler: handler))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showShareSheet(items: [Any]) {
        DispatchQueue.main.async {
            let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
            self.present(activityVC, animated: true)
        }
    }
}
