//
//  Network.swift
//  MovieApp
//
//  Created by Rubén García on 11/12/23.
//


import Foundation
import UIKit

private let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZDVlZTkwMjU0YzVmNTA5NTE3MmEzYmUyMDJkYWVkNCIsInN1YiI6IjU0ODUyOWU3OTI1MTQxNmE2YzAwMWYwMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.wIaFmDZeCYoqdBA79vRvZZTE6vDrugrzaBEQaC8FosI"

private let headers = [
    "accept": "application/json",
    "Authorization": "Bearer \(accessToken)"
]

let movieAPI = URL(string: "https://api.themoviedb.org/3/")!
let popularMovies = movieAPI.appending(path: "movie/popular")
let imagesURL = URL(string: "https://image.tmdb.org")!

extension URL {
    static let popularMovies = movieAPI.appending(path: "movie/popular")
    static func poster(posterPath: String) -> URL {
        return imagesURL.appending(path: "t/p/w500/\(posterPath)")
    }
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
    
    func getPoster(posterPath: String) async -> UIImage? {
        return await downloadImage(from: URL.poster(posterPath: posterPath))
    }
    
    func downloadImage(from url: URL) async -> UIImage? {
        let data = (try? await URLSession.shared.data(from: url))?.0
        
        return data.flatMap { data in
            UIImage(data: data)
        }
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

    func fetchMovies() async -> MoviesResult? {
        let data: Data? = await fetchData(url: URL.popularMovies)
        if let data {
            return try? JSONDecoder().decode(MoviesResult.self, from: data)
        }
        print("⭕️ Error en la decodificación de las peliculas")
        return nil
    }
    
    func genericFetch<T: Decodable>(url: URL, type: T.Type) async -> T? {
        let data: Data? = await fetchData(url: url)
        if let data {
            return try? JSONDecoder().decode(T.self, from: data)
        }
        return nil
    }
}
