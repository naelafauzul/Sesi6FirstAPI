//
//  Joke.swift
//  Sesi6FirstAPI
//
//  Created by Naela Fauzul Muna on 01/02/24.
//

import Foundation

struct Joke: Codable, Identifiable {
    var id: Int
    var type: String
    var setup: String
    var punchline: String
}
