//
//  ViewController.swift
//  WorkshopApp
//
//  Created by Krzysztof Banaczyk on 15/09/2023.
//

import UIKit

class ViewController: UIViewController {
    
    private let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }
    
    private func fetchData() {
        
        viewModel.getPerson_closure()
        
        viewModel.getPerson_closure_generic()
        
        viewModel.getPlanet_publisher()
        
        viewModel.getPlanets_extractedFromContainer()
        
        viewModel.getPlanets_container()
    }
}

