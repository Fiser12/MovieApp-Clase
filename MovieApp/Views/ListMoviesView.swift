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
            ScrollView {
                LazyVStack {
                    if let results = movies?.results {
                        ForEach(results) { movie in
                            NavigationLink(value: movie) {
                                MovieCellView(movie: movie)
                            }
                        }
                    } else {
                        ProgressView()
                    }
                }
            }
            .navigationDestination(for: MovieDto.self) { movie in
                MovieDetailView(movie: movie)
            }
            .navigationTitle("Peliculas destacadas")
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
