//
//  ListMoviesView.swift
//  MovieApp
//
//  Created by Rubén García on 11/12/23.
//

import SwiftUI

struct ListMoviesView: View {
    @State var movies: MoviesResult? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                if let results = movies?.results {
                    ForEach(results) { movie in
                        NavigationLink(value: movie) {
                            Text(movie.title)
                        }
                    }
                } else {
                    ProgressView()
                }
            }
            .navigationDestination(for: MovieDto.self) { movie in
                Text("Detalle de la pelicula \(movie.title)")
            }
        }
        .task {
            let result = await Network.shared.fetchMovies(url: URL.popularMovies)
            if let result {
                movies = result
            }
        }
    }
}

#Preview {
    ListMoviesView()
}
