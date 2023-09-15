//
//  PeopleServicesType.swift
//  WorkshopApp
//
//  Created by Krzysztof Banaczyk on 15/09/2023.
//

import Foundation

enum PeopleServicesType: Service {
    
    case getAll
    case getPerson(id: String)
    
    var endpoint: String {
        switch self {
        case .getAll:               return "/people"
        case let .getPerson(id):    return "/people/\(id)"
        }
    }
}
