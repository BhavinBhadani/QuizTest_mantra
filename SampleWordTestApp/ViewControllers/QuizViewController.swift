//
//  QuizViewController.swift
//  SampleWordTestApp
//
//  Created by Bhavin Bhadani on 12/10/22.
//

import UIKit

class QuizViewController: UIViewController {
    let progressView: UIProgressView = {
        let view = UIProgressView()
        view.progressTintColor = .systemOrange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemCyan
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.allowsSelection = true
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(WordCollectionViewCell.self, forCellWithReuseIdentifier: WordCollectionViewCell.identifier)
        return collectionView
    }()

    var items: [Word] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemCyan
        setupLayout()
    }
    
    // MARK: Helper Functions
    private func setupLayout() {
        view.addSubview(progressView)
        progressView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1.0).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: progressView.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func scrollToNextItem(_ currentIndex: Int) {
        if currentIndex == items.count - 1 {
            navigationController?.popViewController(animated: true)
        } else {
            collectionView.scrollToItem(at: IndexPath(row: currentIndex+1, section: 0), at: .centeredHorizontally, animated: true)
        }
        
        let progress: Float = Float(currentIndex+1) / Float(items.count)
        self.progressView.progress = progress
    }
}

// MARK: UICollectionView Datasource & Delegates
extension QuizViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WordCollectionViewCell.identifier,
                                                            for: indexPath) as? WordCollectionViewCell else {
            fatalError("UICollectionView must be downcasted to WordCollectionViewCell")
        }
        cell.configure(word: items[indexPath.row], index: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: collectionView.bounds.height)
    }
}

extension QuizViewController: WordCollectionViewCellDelegate {
    func againButtonPressed(at index: Int) {
        items.rearrange(from: index, to: items.count-1)
        collectionView.reloadData()
    }
    
    func goodButtonPressed(at index: Int) {
        scrollToNextItem(index)
    }
    
    func easyButtonPressed(at index: Int) {
        scrollToNextItem(index)
    }
}
