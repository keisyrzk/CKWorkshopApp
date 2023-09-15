//
//  PlanetServices.swift
//  WorkshopApp
//
//  Created by Krzysztof Banaczyk on 15/09/2023.
//

import Foundation
import Combine

struct PlanetServices {
    
    func getPlanet_closure_generic(id: String, onComplete: @escaping (ServiceResponse<Planet>) -> Void) {
        services.request_closure_generic(.planet(.getPlanet(id: id)), completion: onComplete)
    }
    
    func getPlanet(id: String) -> AnyPublisher<Planet, ServiceError> {
        return services.request_future(.planet(.getPlanet(id: id))).eraseToAnyPublisher()                // Future + Promise
        //return services.request_publisher(.planet(.getPlanet(id: id))).eraseToAnyPublisher()     // URLSession dataTaskPublisher + AnyPublisher
    }
    
    
    // The tryMap operator is used when the transformation closure you provide can throw an error. In other words, the closure you pass to tryMap should be of the type (Input) throws -> Output. If an error is thrown within this closure, the publisher will emit that error.
    // fetch planets using dedicated `PlanetContainer`
    func getAll_dedicated_container() -> AnyPublisher<[Planet], ServiceError> {
        return services.request_publisher(.planet(.getAll))
            .tryMap { (container: PlanetContainer) -> [Planet] in
                return container.results    // we are interested in [Planet] array so we retrieve it from `container.results`
            }
            .mapError { error in
                return .containerParsing(error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
    
    // alternative - fetch planets using `GenericContainer` that handles all data structures [Person], [Planet]
    func getAll_genericContainer() -> AnyPublisher<[Planet], ServiceError> {
        return services.request_publisher(.planet(.getAll))
            .tryMap { (container: GenericContainer) -> [Planet] in
                if case let .planets(planets) = container.results {
                    return planets
                }
                else {
                    throw ServiceError.containerParsing("Generic Container Parsing failed")
                }
            }
            .mapError { error in
                return .containerParsing(error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
    
    // get the whole container containing planets data
    func getAll_container() -> AnyPublisher<GenericContainer, ServiceError> {
        return services.request_publisher(.planet(.getAll))
    }
}
