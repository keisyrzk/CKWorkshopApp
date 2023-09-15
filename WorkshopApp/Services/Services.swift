//
//  Services.swift
//  WorkshopApp
//
//  Created by Krzysztof Banaczyk on 15/09/2023.
//

import Foundation
import Combine

let services = Services()

class Services {
    
    // list of API's categories/services
    let people  = PeopleServices()
    let planet  = PlanetServices()
}

extension Services {
    
    // MARK: Closure fetch
    func request_closure_fetchPerson(id: String, completion: @escaping (ServiceResponse<Person>) -> Void) {
        
        let baseURL = "https://swapi.dev/api"
        
        guard let url = URL(string: baseURL + ServiceCategory.people(.getPerson(id: id)).requestEndpoint) else {
            completion(.failure(.wrongURL))
            return
        }
        
        // handle async API request
        Task {
            do {
                let data = try await URLSession.shared.data(from: url).0
                let decodedData = try JSONDecoder().decode(Person.self, from: data)
                // notify about succeeded data decoding
                completion(.success(decodedData))
            } catch {
                // throw the error caught on `try await URLSession.shared.data(from: url).0`
                completion(.failure(.custom(error.localizedDescription)))
            }
        }
    }
    
    
    /*
     /////////////////////////////////////////////////////////////////////////////
     /////////////////////////////////////////////////////////////////////////////
     */
    
    
    // MARK: Closure fetch - generic
    func request_closure_generic<T: Decodable>(_ service: ServiceCategory, completion: @escaping (ServiceResponse<T>) -> Void) {
        
        let baseURL = "https://swapi.dev/api"
        
        guard let url = URL(string: baseURL + service.requestEndpoint) else {
            completion(.failure(.wrongURL))
            return
        }
        
        // handle async API request
        Task {
            do {
                let data = try await URLSession.shared.data(from: url).0
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                // notify about succeeded data decoding
                completion(.success(decodedData))
            } catch {
                // throw the error caught on `try await URLSession.shared.data(from: url).0`
                completion(.failure(.custom(error.localizedDescription)))
            }
        }
    }
    
    
    /*
     /////////////////////////////////////////////////////////////////////////////
     /////////////////////////////////////////////////////////////////////////////
     */
    
    
    // MARK: Reactive fetch - Future
    /*
     generic function that actually fetches data from API based on given
     - baseURL
     - category
     - associated parameters
     
     the function returns
     - publisher (specified with `Future` in this case) that emits fetched data (of type the compiler gets from the context)
     - eventual error mapped to custom `ServiceError`
     
     */
    func request_future<T: Decodable>(_ service: ServiceCategory) -> Future<T, ServiceError> {
        
        let baseURL = "https://swapi.dev/api"
        
        return Future { promise in
            
            guard let url = URL(string: baseURL + service.requestEndpoint) else {
                promise(.failure(.wrongURL))
                return
            }
            
            // handle async API request
            Task {
                do {
                    // await the completion of the async API request
                    let data = try await URLSession.shared.data(from: url).0
                    // try to decode the data into the expected Decodable type
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    // notify about succeeded data decoding, If decoding is successful, complete the Future with the decoded data
                    promise(.success(decodedData))
                } catch {
                    // throw the error caught on `try await URLSession.shared.data(from: url).0`,  If either fetching data or decoding fails, complete the Future with a custom error
                    promise(.failure(.custom(error.localizedDescription)))
                }
            }
        }
    }
    
    
    /*
     /////////////////////////////////////////////////////////////////////////////
     /////////////////////////////////////////////////////////////////////////////
     */
    
    
    // MARK: Reactive fetch - dataTaskPublisher
    // an alternative approach using directly `dataTaskPublisher`
    func request_publisher<T: Decodable>(_ service: ServiceCategory) -> AnyPublisher<T, ServiceError> {
        
        let baseURL = "https://swapi.dev/api"
        
        guard let url = URL(string: baseURL + service.requestEndpoint) else {
            return Fail(error: ServiceError.wrongURL).eraseToAnyPublisher()
        }
        
        // start a URLSession data task as a publisher for the constructed URL
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)    // extract the data part from the URLSession response
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> ServiceError in
                if let decodingError = error as? DecodingError {
                    return .custom(decodingError.localizedDescription)
                } else if let urlError = error as? URLError {
                    return .custom(urlError.localizedDescription)
                } else {
                    return .custom(error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }
}
