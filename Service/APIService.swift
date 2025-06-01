//
//  APIService.swift
//  PDFReportGenerator-UIKit
//
//  Created by Adarsh on 30/05/25.
//

import Foundation

enum APIServiceError: Error {
    case invalidURL
    case invalidResponse
    case decodingFailed
    case networkError(Error)
}

protocol APIService {
    func fetchData<T: Codable>(url: String, responseType: T.Type, completion: @escaping (Result<T, APIServiceError>) -> Void)
}
