//
//  PDFService.swift
//  PDFReportGenerator-UIKit
//
//  Created by Adarsh on 30/05/25.
//

import Foundation

protocol PDFService {
    
    associatedtype Model: Codable
    
    static func generatePDF(from model: Model, title: String, completion: @escaping (URL?) -> Void)
}
