//
//  Enums.swift
//  SampleWordTestApp
//
//  Created by Bhavin Bhadani on 12/10/22.
//

import Foundation

enum APIError: String, Error {
    case noNetwork = "No Network"
    case serverOverload = "Server is overloaded"
    case permissionDenied = "You don't have permission"
    case invalidFilePath = "Invalid file path"
    case unableToParseData = "Unable to parse data"
}

extension Array {
    mutating func rearrange(from: Int, to: Int) {
        insert(remove(at: from), at: to)
    }
}
