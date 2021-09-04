//
//  Character.swift
//  Marvel
//
//  Created by Julie Connors on 9/4/21.
//

import Foundation

struct CharacterList: Decodable {
    let results: [Character]
}

struct Character: Decodable {
    let name: String
}
