//
//  ViewModel.swift
//  WorkshopApp
//
//  Created by Krzysztof Banaczyk on 15/09/2023.
//

import Combine


class ViewModel {
    
    private var cancellables = Set<AnyCancellable>()
    
    func getPerson_closure() {
        services.people.getPerson_closure_fetchPerson(id: "1") { response in
            switch response {
            case let .failure(error):
                print(error.message)
            case let .success(person):
                print(person)
            }
        }
    }
    
    func getPerson_closure_generic() {
        services.people.getPerson_closure_generic(id: "2") { response in
            switch response {
            case let .failure(error):
                print(error.message)
            case let .success(person):
                print(person)
            }
        }
    }
    
    func getPlanet_publisher() {
        services.planet.getPlanet(id: "1")
            .sink { [unowned self] result in
                if case let .failure(error) = result {
                    print(error)        // errorPublisher.send(error)
                }
            } receiveValue: { [unowned self] planet in
                print(planet)        // onPlanet.send(planet)
            }
            .store(in: &cancellables)
    }
    
    // get Planets already extracted from embed container
    func getPlanets_extractedFromContainer() {
        services.planet.getAll_genericContainer()    // fetch using GenericContainer
            .sink { result in
                if case let .failure(error) = result {
                    print(error)        // errorPublisher.send(error)
                }
            } receiveValue: { planets in
                print("Planets:\n \(planets)")
            }
            .store(in: &cancellables)
    }
    
    // get whole container containing `results` attribute with Planets
    func getPlanets_container() {
        services.planet.getAll_container()
            .sink { result in
                if case let .failure(error) = result {
                    print(error)        // errorPublisher.send(error)
                }
            } receiveValue: { container in
                print("Planets container:\n \(container)")
            }
            .store(in: &cancellables)
    }
}
