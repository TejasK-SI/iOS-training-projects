//
//  MemeData.swift
//  Day1OnFloor
//
//  Created by Tejas Kashid on 02/11/23.
//

import Foundation
struct MemeData: Codable {
    let data: Memes
}

struct Memes: Codable {
    let memes: [DetailsStructure]
}


struct DetailsStructure: Codable {
    let name: String
    let url: String
}
