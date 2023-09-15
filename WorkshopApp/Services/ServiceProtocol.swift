//
//  ServiceProtocol.swift
//  WorkshopApp
//
//  Created by Krzysztof Banaczyk on 15/09/2023.
//

import Foundation

// to ensure the `endpoint` attribute is present in all `Services`
protocol Service {
    var endpoint: String { get }
}
