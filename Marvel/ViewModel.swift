//
//  ViewModel.swift
//  Marvel
//
//  Created by Julie Connors on 9/4/21.
//

import Foundation

class ViewModel {
    
    var viewModel: CharacterList? {
        didSet {
            DispatchQueue.main.async {
                self.updateClosure?()
            }
        }
    }
    
    let charactersToFetch = "https://gateway.marvel.com:443/v1/public/characters?ts=marvel&apikey=4b52992ce24c7f32bd54bdabc7717050&hash=f173d7550279f53565b7fc469faa5be9"
    
    init() {
        fetchCharacters()
    }
    
    func fetchCharacters() {
        print("fetching characters")
    }
    
    func bind(completion: @escaping () -> Void) {
        self.updateClosure = completion
    }
    
    var updateClosure: (() -> Void)?
    
    
}
