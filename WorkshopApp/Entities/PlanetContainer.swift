//
//  PlanetContainer.swift
//  WorkshopApp
//
//  Created by Krzysztof Banaczyk on 15/09/2023.
//

import Foundation

struct PlanetContainer: Decodable {
    
    let count:      Int
    let next:       String?
    let previous:   String?
    let results:    [Planet]
}
