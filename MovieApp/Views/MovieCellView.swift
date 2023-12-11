//
//  MovieCellView.swift
//  MovieApp
//
//  Created by Rubén García on 11/12/23.
//

import SwiftUI

struct MovieCellView: View {
    let movie: MovieDto
    
    var body: some View {
        Text(movie.title)
            .font(.title)
    }
}

#Preview {
    MovieCellView(movie: MovieDto.test)
}
