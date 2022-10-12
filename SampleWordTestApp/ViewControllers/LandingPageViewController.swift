//
//  LandingPageViewController.swift
//  SampleWordTestApp
//
//  Created by Bhavin Bhadani on 12/10/22.
//

import UIKit

class LandingPageViewController: UIViewController {
    // MARK: View Controls
    let containerView1: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let containerView2: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .fill
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let totalWordsStackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .fill
        view.axis = .vertical
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let totalTitleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.textAlignment = .center
        view.text = "Total Learning Words"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let totalCountLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 17, weight: .medium)
        view.textAlignment = .center
        view.text = "0"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let reviewWordsStackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .fill
        view.axis = .vertical
        view.spacing = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let reviewTitleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.textAlignment = .center
        view.text = "Words To Review"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let reviewCountLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 17, weight: .medium)
        view.textAlignment = .center
        view.text = "0"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let startButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .systemOrange
        view.setTitleColor(.white, for: .normal)
        view.setTitle("START", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // Properties
    lazy private var viewModel : WordsViewModel = {
        let viewModel = WordsViewModel()
        return viewModel
    }()
    
    var items: [Word] = []

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        setupLayout()
        viewModel.delegate = self
        viewModel.fetchWords()
    }
    
    // MARK: Helper Functions
    private func setupLayout() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(containerView1)
        stackView.addArrangedSubview(containerView2)
        
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30).isActive = true
        
        containerView1.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        containerView1.addSubview(totalWordsStackView)
        totalWordsStackView.addArrangedSubview(totalTitleLabel)
        totalWordsStackView.addArrangedSubview(totalCountLabel)
        totalWordsStackView.leadingAnchor.constraint(equalTo: containerView1.leadingAnchor, constant: 10).isActive = true
        totalWordsStackView.trailingAnchor.constraint(equalTo: containerView1.trailingAnchor, constant: -10).isActive = true
        totalWordsStackView.centerXAnchor.constraint(equalTo: containerView1.centerXAnchor).isActive = true
        totalWordsStackView.centerYAnchor.constraint(equalTo: containerView1.centerYAnchor).isActive = true

        containerView2.addSubview(reviewWordsStackView)
        reviewWordsStackView.addArrangedSubview(reviewTitleLabel)
        reviewWordsStackView.addArrangedSubview(reviewCountLabel)
        reviewWordsStackView.leadingAnchor.constraint(equalTo: containerView2.leadingAnchor, constant: 10).isActive = true
        reviewWordsStackView.trailingAnchor.constraint(equalTo: containerView2.trailingAnchor, constant: -10).isActive = true
        reviewWordsStackView.centerXAnchor.constraint(equalTo: containerView2.centerXAnchor).isActive = true
        reviewWordsStackView.centerYAnchor.constraint(equalTo: containerView2.centerYAnchor).isActive = true
        
        view.addSubview(startButton)
        startButton.addTarget(self, action: #selector(startTheQuiz(_:)), for: .touchUpInside)
        startButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        startButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20).isActive = true
        startButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true

    }
    
    @objc func startTheQuiz(_ sender: UIButton) {
        var itemsForQuiz: [Word] = []
        
        if items.count < 10 {
            items = self.viewModel.words ?? []
        }
        items.shuffle()
        for i in 1...10 {
            itemsForQuiz.append(items[i])
            items.removeFirst()
        }
        
        let vc = QuizViewController()
        vc.items = itemsForQuiz
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - WordsViewModelDelegate
extension LandingPageViewController: WordsViewModelDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.totalCountLabel.text = "\(self.viewModel.words?.count ?? 0)"
        }
    }
    
    func presentError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
