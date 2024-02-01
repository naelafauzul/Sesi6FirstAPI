//
//  ApiServices.swift
//  Sesi6FirstAPI
//
//  Created by Naela Fauzul Muna on 01/02/24.
//

import Foundation

class ApiServices {
    static let shared = ApiServices()
    
    private init() {}
    
    func fetchJokeServices(jokeType: String) async throws -> Joke {
        let urlString = URL(string: "\(Constant.jokeApi)/\(jokeType)/1")
        
        guard let url = urlString else {
            print("Error: Could not convert \(urlString?.absoluteString ?? "unknown") to a URL")
            throw URLError(.badURL)
        }
        
        print("We are accessing the url \(url)")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.init(rawValue: httpResponse.statusCode ))
        }
        
        let joke = try JSONDecoder().decode([Joke].self, from: data)
        return joke[0]
    }
}
