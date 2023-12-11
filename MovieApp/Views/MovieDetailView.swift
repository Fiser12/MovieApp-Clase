//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Rubén García on 11/12/23.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: MovieDto
    
    var body: some View {
        Text("Detalle de la pelicula \(movie.title)")
            .navigationTitle(movie.title)
    }
}

#Preview {
    MovieDetailView(movie: .test)
}
