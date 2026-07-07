//
//  RepositoryError.swift
//  Crypto
//
//  Created by tiago on 04/06/2026.
//

import Foundation

// MARK: - ENUM
enum RepositoryError: Error {
    case dataAlreadyExists
    case notFound
    case invalidData
    case databaseFailure(underlyingError: Error)
}
