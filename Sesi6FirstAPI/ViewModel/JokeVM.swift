//
//  JokeVM.swift
//  Sesi6FirstAPI
//
//  Created by Naela Fauzul Muna on 01/02/24.
//

import Foundation

class JokeVM: ObservableObject {
    @Published var joke: Joke?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var currentIndex: Int = 0
    
    func fetchJoke(jokeType: String) async {
        DispatchQueue.main.async {
            self.isLoading = true
            self.errorMessage = nil
        }
        
        
        do {
            let fetchedJoke = try await ApiServices.shared.fetchJokeServices(jokeType: jokeType)
            DispatchQueue.main.async{
                self.joke = fetchedJoke
                print("Setup: \(self.joke?.setup ?? "No Setup")")
                print("Punchline: \(self.joke?.punchline ?? "No Punchline")")
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async{
                self.errorMessage = error.localizedDescription
                self.isLoading = false
                print("Error: Could not get data from URL: \(Constant.jokeApi).\(error.localizedDescription)")
            }
        }
    }
    
    func fetchNextJoke(jokeType: String) async {
            do {
                currentIndex += 1
                joke = try await ApiServices.shared.fetchJokeServices(jokeType: jokeType)
            } catch {
                print("Error fetching joke: \(error)")
            }
        }
    
    
}
    
