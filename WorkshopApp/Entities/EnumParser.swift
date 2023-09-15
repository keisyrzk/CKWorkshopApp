//
//  EnumParser.swift
//  WorkshopApp
//
//  Created by Krzysztof Banaczyk on 15/09/2023.
//

import Foundation

// this is how the container always looks like, except the data in `results` attribute. This one will be parsed dynamically.
struct GenericContainer: Decodable {
    
    let count:      Int
    let next:       String?
    let previous:   String?
    let results:    GenericContainerResult
}


// the enum parses data whatever type they are
enum GenericContainerResult: Decodable {
    
    case people     ([Person])
    case planets    ([Planet])
    
    init(from decoder: Decoder) throws {
        //  `Single Value Container`: allows the decoder to decode a single value at the current decoding location.
        let container = try decoder.singleValueContainer()
        
        if let people = try? container.decode([Person].self) {
            self = .people(people)
        }
        else if let planets = try? container.decode([Planet].self) {
            self = .planets(planets)
        }
        // etc.
        else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid data for GenericContainerResult"
            )
        }
    }
}
