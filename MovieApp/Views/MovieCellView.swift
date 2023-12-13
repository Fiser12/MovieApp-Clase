//
//  MovieCellView.swift
//  MovieApp
//
//  Created by Rubén García on 11/12/23.
//

import SwiftUI

struct MovieCellView: View {
    let movie: MovieDto
    @State var poster: UIImage? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            if let poster {
                Image(uiImage: poster)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 10, x: 5, y: 5)
            }
            
        }
        .task {
            guard let posterPath = movie.posterPath else { return }
            self.poster = await Network.shared.getPoster(posterPath: posterPath)
        }
    }
}

#Preview {
    MovieCellView(movie: MovieDto.test)
}
