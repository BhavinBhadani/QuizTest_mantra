//
//  WordListService.swift
//  SampleWordTestApp
//
//  Created by Bhavin Bhadani on 12/10/22.
//

import Foundation

protocol WordListServiceProtocol {
    func fetchWords(completion: @escaping (Result<[Word], APIError>) -> ())
}

class WordListService: WordListServiceProtocol {
    func fetchWords(completion: @escaping (Result<[Word], APIError>) -> ()) {
        DispatchQueue.global().async {
            guard let path = Bundle.main.path(forResource: "sample_dictionary", ofType: "json") else {
                completion(.failure(APIError.invalidFilePath))
                return
            }
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let categories = try JSONDecoder().decode([Word].self, from: data)
                completion(.success(categories))
            } catch let error {
                print("Fetch categories Error: \(error.localizedDescription)")
                completion(.failure(APIError.unableToParseData))
            }
        }
    }
}
