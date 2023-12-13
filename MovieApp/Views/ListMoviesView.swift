//
//  ListMoviesView.swift
//  MovieApp
//
//  Created by Rubén García on 11/12/23.
//

import SwiftUI

final class ListMoviesState: ObservableObject {
    @Published var movies: MoviesResult? = nil
    @Published var searchText = ""
    var task: Task<Void, Never>?

    @MainActor
    func loadData() async {
        movies = await Network.shared.fetchPopularMovies()
    }
    
    func isShowingMoview(movie: MovieDto) -> Bool {
        return searchText.isEmpty || movie.title.contains(searchText) || movie.originalTitle.contains(searchText)
    }
    
    
    func search(query: String) {
        task = Task { @MainActor in
            if searchText.isEmpty {
                return
            }
            
            let movies = await Network.shared.searchMovies(query: query)
            if let movies {
                self.movies = movies
            }
        }
    }
    
}

struct ListMoviesView: View {
    @StateObject var state = ListMoviesState()
    
    var body: some View {
        NavigationStack {
            SearchTextView(searchText: $state.searchText)
                .padding(10)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 117))]) {
                    if let results = state.movies?.results {
                        ForEach(results) { movie in
                            NavigationLink(value: movie) {
                                MovieCellView(movie: movie)
                            }
                            .transition(.scale)
                        }
                    } else {
                        ProgressView()
                    }
                }
            }
            .animation(.easeInOut, value: state.searchText)
            .contentMargins(12, for: .scrollContent)
            .scrollBounceBehavior(.basedOnSize)
            .navigationDestination(for: MovieDto.self) { movie in
                MovieDetailView(movie: movie)
            }
            .navigationTitle("Peliculas destacadas")
        }
        .task {
            await state.loadData()
        }
        .onReceive(state.$searchText
            .removeDuplicates()
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
        ) { searchText in
            state.search(query: searchText)
        }
    }
}

#Preview {
    ListMoviesView()
}
