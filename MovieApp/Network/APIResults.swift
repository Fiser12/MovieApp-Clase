//
//  APIResults.swift
//  MovieApp
//
//  Created by Rubén García on 11/12/23.
//

import Foundation

struct MoviesResult: Decodable {
    let page: Int
    let results: [MovieDto]
}

struct MovieDto: Decodable, Identifiable, Hashable {
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String
    let posterPath: String?
    let genreIDS: [Int]
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case genreIDS = "genre_ids"
        case releaseDate = "release_date"
    }
}
