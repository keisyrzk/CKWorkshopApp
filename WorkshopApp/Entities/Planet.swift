//
//  Planet.swift
//  WorkshopApp
//
//  Created by Krzysztof Banaczyk on 15/09/2023.
//

import Foundation

struct Planet: Decodable {
    
    let name:   String
    let terrain:    String
    let residents:  [String]
}
