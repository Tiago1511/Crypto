//
//  ServiceRequest.swift
//  Crypto
//
//  Created by tiago on 01/01/2026.
//

import Foundation
import Alamofire
import UIKit

final class ServiceRequest {
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
        
}

