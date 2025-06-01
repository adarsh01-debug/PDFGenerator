//
//  TransactionModel.swift
//  PDFReportGenerator-UIKit
//
//  Created by Adarsh on 30/05/25.
//

import Foundation

struct TransactionModel: Codable {
    let date: String?
    let narration: String?
    let transactionId: String?
    let status: String?
    let credit: String?
}
