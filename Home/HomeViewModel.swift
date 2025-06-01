//
//  HomeViewModel.swift
//  PDFReportGenerator-UIKit
//
//  Created by Adarsh on 30/05/25.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func didFetchTransactions(_ pdfUrl: URL)
    func didFinishWithError(_ error: APIServiceError)
    func showLoader(_ show: Bool)
}

class HomeViewModel {
    var transactions = [TransactionModel]()

    weak var delegate: HomeViewModelDelegate?

    func generatePDF() {
        if let cachedData: [TransactionModel] = CacheService.shared.get(forKey: StorageKeys.transactionPdfDataKey) {
            transactions = cachedData
            generatePdfUrl()
            return
        }

        delegate?.showLoader(true)
        NetworkManager.shared.fetchData(url: ApiRoutes.getTransactions, responseType: [TransactionModel].self) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let transactions):
                self.transactions = transactions
                CacheService.shared.save(transactions, forKey: StorageKeys.transactionPdfDataKey)
                self.generatePdfUrl()
            case .failure(let error):
                self.delegate?.showLoader(false)
                self.delegate?.didFinishWithError(error)
            }
        }
    }

    func generatePdfUrl() {
        
        TransactionPDFService.generatePDF(from: transactions, title: "Transactions Report") { [weak self] url in
            self?.delegate?.showLoader(false)
            guard let pdfUrl = url, let self else { return }
            self.delegate?.didFetchTransactions(pdfUrl)
        }
    }
}
