//
//  WordsViewModel.swift
//  SampleWordTestApp
//
//  Created by Bhavin Bhadani on 12/10/22.
//

import Foundation

protocol WordsViewModelDelegate: AnyObject {
    func reloadData()
    func presentError(_ message: String)
}

class WordsViewModel: NSObject {
    private(set) var words : [Word]?
    weak var delegate: WordsViewModelDelegate?
    
    override init() {
        super.init()
        fetchWords()
    }
    
    func fetchWords() {
        WordListService().fetchWords { result in
            switch result {
            case .success(let words):
                self.words = words
                self.delegate?.reloadData()
            case .failure(let e):
                self.delegate?.presentError(e.rawValue)
            }
        }
    }
}
