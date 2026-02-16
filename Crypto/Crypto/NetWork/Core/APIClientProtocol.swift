//
//  APIClientProtocol.swift
//  Crypto
//
//  Created by tiago on 14/02/2026.
//

import Foundation
import Alamofire
import SwiftUI

protocol APIClientProtocol {
    
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        parameters: Parameters?,
        encoding: ParameterEncoding,
        headers: HTTPHeaders?,
        cachePolicy: CachePolicy
    ) async throws -> T
    
    func fetchImage(
        endpoint: String,
        headers: HTTPHeaders?,
        cachePolicy: CachePolicy
    ) async throws -> UIImage
}
