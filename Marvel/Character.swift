//
//  Character.swift
//  Marvel
//
//  Created by Julie Connors on 9/4/21.
//

import Foundation

struct CharacterData: Decodable {
    let data: CharacterList
}

struct CharacterList: Decodable {
    let results: [Character]
}

struct Character: Decodable {
    let name: String
    let resourceURI: String
    let thumbnail: Image
}

struct Comic: Decodable {
    let collectionURI: String
}

struct Image: Decodable {
    enum CodingKeys: String, CodingKey{
        case fileType = "extension"
        case path = "path"
    }
    let path: String
    let fileType: String
}
