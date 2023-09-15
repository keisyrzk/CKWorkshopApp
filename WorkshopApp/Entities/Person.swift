//
//  Person.swift
//  WorkshopApp
//
//  Created by Krzysztof Banaczyk on 15/09/2023.
//

import Foundation

struct Person: Decodable {
    
    let name:       String
    let gender:     Gender
    let homeworld:  String
}
