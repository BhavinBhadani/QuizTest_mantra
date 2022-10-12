//
//  WordCollectionViewCell.swift
//  SampleWordTestApp
//
//  Created by Bhavin Bhadani on 12/10/22.
//

import UIKit

protocol WordCollectionViewCellDelegate: AnyObject {
    func againButtonPressed(at index: Int)
    func goodButtonPressed(at index: Int)
    func easyButtonPressed(at index: Int)
}

class WordCollectionViewCell: UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }

    private var containerContentView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .systemCyan
        return container
    }()
    
    private var wordNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private var wordDetailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 15
        return stack
    }()
    
    let againButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .black
        view.setTitleColor(.white, for: .normal)
        view.setTitle("Again", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let goodButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .systemRed
        view.setTitleColor(.white, for: .normal)
        view.setTitle("Good", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let easyButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .systemOrange
        view.setTitleColor(.white, for: .normal)
        view.setTitle("Easy", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    weak var delegate: WordCollectionViewCellDelegate?
    var index: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        wordDetailLabel.isHidden = true
        stackView.isHidden = true
    }

    private func setupLayout() {
        addSubview(containerContentView)
        containerContentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerContentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerContentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerContentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        containerContentView.addSubview(wordNameLabel)
        wordNameLabel.topAnchor.constraint(equalTo: containerContentView.topAnchor, constant: 20).isActive = true
        wordNameLabel.leadingAnchor.constraint(equalTo: containerContentView.leadingAnchor, constant: 20).isActive = true
        wordNameLabel.trailingAnchor.constraint(equalTo: containerContentView.trailingAnchor, constant: -20).isActive = true

        containerContentView.addSubview(wordDetailLabel)
        wordDetailLabel.leadingAnchor.constraint(equalTo: containerContentView.leadingAnchor, constant: 20).isActive = true
        wordDetailLabel.trailingAnchor.constraint(equalTo: containerContentView.trailingAnchor, constant: -20).isActive = true
        wordDetailLabel.topAnchor.constraint(equalTo: wordNameLabel.bottomAnchor, constant: 8).isActive = true
        wordDetailLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        containerContentView.addSubview(stackView)
        stackView.addArrangedSubview(againButton)
        stackView.addArrangedSubview(goodButton)
        stackView.addArrangedSubview(easyButton)
        stackView.leadingAnchor.constraint(equalTo: containerContentView.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: containerContentView.trailingAnchor, constant: -20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: containerContentView.bottomAnchor, constant: -40).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        againButton.addTarget(self, action: #selector(againButtonPressed), for: .touchUpInside)
        goodButton.addTarget(self, action: #selector(goodButtonPressed), for: .touchUpInside)
        easyButton.addTarget(self, action: #selector(easyButtonPressed), for: .touchUpInside)

        wordDetailLabel.isHidden = true
        stackView.isHidden = true
        
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = 1
        tap.addTarget(self, action: #selector(displayDetail))
        containerContentView.addGestureRecognizer(tap)
    }
    
    @objc func displayDetail() {
        wordDetailLabel.isHidden = false
        stackView.isHidden = false
    }
    
    @objc func againButtonPressed() {
        delegate?.againButtonPressed(at: index)
    }

    @objc func goodButtonPressed() {
        delegate?.goodButtonPressed(at: index)
    }
    
    @objc func easyButtonPressed() {
        delegate?.easyButtonPressed(at: index)
    }
    
    func configure(word: Word, index: Int) {
        self.index = index
        wordNameLabel.text = word.word
        wordDetailLabel.text = word.glossary
    }
}
