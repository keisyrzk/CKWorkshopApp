//
//  ServiceResponse.swift
//  WorkshopApp
//
//  Created by Krzysztof Banaczyk on 15/09/2023.
//

import Foundation

// sample custom implemention of a response - similar to built-in `Result`
enum ServiceResponse<T> {
    case success(T)
    case failure(ServiceError)
}
