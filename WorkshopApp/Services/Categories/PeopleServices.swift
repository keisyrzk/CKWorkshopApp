//
//  PeopleServices.swift
//  WorkshopApp
//
//  Created by Krzysztof Banaczyk on 15/09/2023.
//

import Foundation
import Combine

struct PeopleServices {
    
    func getPerson_closure_fetchPerson(id: String, onComplete: @escaping (ServiceResponse<Person>) -> Void) {
        services.request_closure_fetchPerson(id: id, completion: onComplete)
    }
    
    func getPerson_closure_generic(id: String, onComplete: @escaping (ServiceResponse<Person>) -> Void) {
        services.request_closure_generic(.people(.getPerson(id: id)), completion: onComplete)
    }
    
    func getPerson(id: String) -> AnyPublisher<Person, ServiceError> {
        return services.request_future(.people(.getPerson(id: id))).eraseToAnyPublisher()        // Future + Promise
        //return services.request_publisher(.people(.getPerson(id: id))).eraseToAnyPublisher()     // URLSession dataTaskPublisher + AnyPublisher
    }
}
