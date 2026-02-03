//
//  ServiceRequest.swift
//  arteScope
//
//  Created by tiago on 01/01/2026.
//

import Foundation
import Alamofire
import UIKit

final class ServiceRequest {
    
    // MARK: - Singleton
    static let shared = ServiceRequest()
    
    private var header: HTTPHeaders
    
    private var apiClient: APIClient = .shared
    
    init() {
        self.header = HTTPHeaders()
    }
        
}

