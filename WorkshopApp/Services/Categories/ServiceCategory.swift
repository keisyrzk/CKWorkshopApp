//
//  ServiceCategory.swift
//  WorkshopApp
//
//  Created by Krzysztof Banaczyk on 15/09/2023.
//

import Foundation

// category reflects common API structure
enum ServiceCategory {
    
    case people (PeopleServicesType)
    case planet (PlanetServicesType)
    
    var requestEndpoint: String {
        switch self {
        case let .people(service):  return service.endpoint
        case let .planet(service):  return service.endpoint
        }
    }
}
