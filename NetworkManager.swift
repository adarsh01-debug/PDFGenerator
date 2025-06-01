//
//  NetworkManager.swift
//  PDFReportGenerator-UIKit
//
//  Created by Adarsh on 01/06/25.
//

import Foundation

final class NetworkManager: APIService {
    
    static let shared = NetworkManager()

    private init() { }

    func fetchData<T: Codable>(url: String, responseType: T.Type, completion: @escaping (Result<T, APIServiceError>) -> Void) {

        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(.networkError(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                  let data = data else {
                completion(.failure(.invalidResponse))
                return
            }

            do {
                let responseModel = try JSONDecoder().decode(T.self, from: data)
                completion(.success(responseModel))
            } catch {
                completion(.failure(.decodingFailed))
            }

        }.resume()
    }
}
