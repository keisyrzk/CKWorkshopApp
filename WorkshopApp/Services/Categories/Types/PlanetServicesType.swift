//
//  PlanetServicesType.swift
//  WorkshopApp
//
//  Created by Krzysztof Banaczyk on 15/09/2023.
//

import Foundation

enum PlanetServicesType: Service {
    
    case getAll
    case getPlanet(id: String)
    
    var endpoint: String {
        switch self {
        case .getAll:               return "/planets"
        case let .getPlanet(id):    return "/planets/\(id)"
        }
    }
}
