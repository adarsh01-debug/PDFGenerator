//
//  HomeViewController.swift
//  PDFReportGenerator-UIKit
//
//  Created by Adarsh on 30/05/25.
//

import UIKit

class HomeViewController: UIViewController {

    private var viewModel: HomeViewModel?

    private lazy var generatePDFButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitle("Generate PDF", for: .normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(generatePDFButtonCTA), for: .touchUpInside)
        return button
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .gray
        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "PDF Report Generator"
        registerViewModel()
        addViews()
        layoutConstraints()
    }

    private func registerViewModel() {
        viewModel = HomeViewModel()
        viewModel?.delegate = self
    }

    private func addViews() {
        view.addSubview(generatePDFButton)
        view.addSubview(activityIndicator)
    }

    private func layoutConstraints() {
        NSLayoutConstraint.activate([
            generatePDFButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            generatePDFButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            generatePDFButton.heightAnchor.constraint(equalToConstant: 70),
            generatePDFButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.5)
        ])
        
        activityIndicator.center = view.center
    }

    @objc
    private func generatePDFButtonCTA() {
        viewModel?.generatePDF()
    }
}

extension HomeViewController: HomeViewModelDelegate {
    
    func didFetchTransactions(_ pdfUrl: URL) {
        DispatchQueue.main.async {
            let pdfVC = TransactionPDFViewController(pdfURL: pdfUrl)
            let navController = UINavigationController(rootViewController: pdfVC)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true)
        }
    }
    
    func didFinishWithError(_ error: APIServiceError) {
        
        switch error {
        case .networkError(let error):
            showAlert(title: "No internet connection", message: error.localizedDescription, actionTitle: nil)
        default:
            showAlert(title: "Error occured", message: "Unknown error occured, please try again.", actionTitle: nil)
        }
    }
    
    func showLoader(_ show: Bool) {
        show ? startActivityAnimation() : stopActivityAnimation()
    }
}

extension HomeViewController {
    
    private func startActivityAnimation() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.view.backgroundColor = .gray.withAlphaComponent(0.3)
        }
    }
    
    private func stopActivityAnimation() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.view.backgroundColor = .white
        }
    }
}
