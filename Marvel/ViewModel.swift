//
//  ViewModel.swift
//  Marvel
//
//  Created by Julie Connors on 9/4/21.
//

import Foundation
import UIKit.UIImage

class ViewModel {
    
    var characterViewModel: CharacterList? {
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
        let characterURL = URL(string: charactersToFetch)
        
        guard let url = characterURL else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            let characterList = try? JSONDecoder().decode(CharacterData.self, from: data)
            if let characters = characterList?.data {
                self.characterViewModel = characters
            }
        }.resume()
    }
    
    func bind(completion: @escaping () -> Void) {
        self.updateClosure = completion
    }
    
    var updateClosure: (() -> Void)?
    
    func formatImageStr(character: Character) -> String {
        var path =  character.thumbnail.path
        let start =  path.startIndex
        let nextIndex = path.index(start, offsetBy: 4)
        path.insert("s", at: nextIndex)
        let imageStr = path + "." + character.thumbnail.fileType
        return imageStr
    }
    
    func fetchImages(imageStr: String, completion: @escaping (UIImage?) -> Void) {
        if let image = ImageCache.shared.findImage(string: imageStr) {
            completion(image)
        } else {
            guard let url = URL(string: imageStr) else { fatalError() }
            
            URLSession.shared.dataTask(with: url) { data, _, _ in
                DispatchQueue.main.async {
                    if let data = data, let image = UIImage(data: data) {
                    ImageCache.shared.addImage(string: imageStr, image: image)
                        completion(image)
                    }
                }
            }.resume()
        }
    }
}
