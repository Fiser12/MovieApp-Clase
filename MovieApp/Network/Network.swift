//
//  Network.swift
//  MovieApp
//
//  Created by Rubén García on 11/12/23.
//


import Foundation

private let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZDVlZTkwMjU0YzVmNTA5NTE3MmEzYmUyMDJkYWVkNCIsInN1YiI6IjU0ODUyOWU3OTI1MTQxNmE2YzAwMWYwMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.wIaFmDZeCYoqdBA79vRvZZTE6vDrugrzaBEQaC8FosI"

private let headers = [
    "accept": "application/json",
    "Authorization": "Bearer \(accessToken)"
]

let movieAPI = URL(string: "https://api.themoviedb.org/3/")!
let popularMovies = movieAPI.appending(path: "movie/popular")

extension URL {
    static let popularMovies = movieAPI.appending(path: "movie/popular")

}

final class Network {
    static let shared = Network()
    
    func fetch(url: URL) async -> String? {
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print(data)
            let dataStr = String(data: data, encoding: .utf8)
            
            return dataStr
        } catch {
            print("⭕️ \(error)")
        }
        return nil
    }
    
    private func fetchData(url: URL) async -> Data? {
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return data
        } catch {
            print("⭕️ \(error)")
        }
        return nil
    }

    func fetchMovies(url: URL) async -> MoviesResult? {
        let data: Data? = await fetchData(url: url)
        if let data {
            return try? JSONDecoder().decode(MoviesResult.self, from: data)
        }
        print("⭕️ Error en la decodificación de las peliculas")
        return nil
    }
}
