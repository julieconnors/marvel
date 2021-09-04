//
//  ViewController.swift
//  Marvel
//
//  Created by Julie Connors on 9/4/21.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewModel()
    }
    
    func setUpViewModel() {
        viewModel =  ViewModel()
        
        let completion = { [weak self] in
            guard let wself = self else { return }
            
            wself.loadCharacters()
        }
        
        viewModel.bind(completion: completion)
    }
    
    func loadCharacters() {
        print("loading characters")
    }
}

