//
//  MovieBackdropCarousel.swift
//  TutorialMovie
//
//  Created by Jose Angel Cortes Gomez on 10/01/21.
//

import SwiftUI

struct MovieBackdropCarouselView: View {
    
    var title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(self.movies) { movie in
                        NavigationLink(
                            destination: MovieDetailView(movieId: movie.id)){
                                MovieBackdropCard(movie: movie)
                                    .frame(width: 306, height: 204)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.leading, movie.id == self.movies.first!.id ? 16 : 0)
                            .padding(.leading, movie.id == self.movies.last!.id ? 16 : 0)
                    }
                }
            }
        }
    }
}

struct MovieBackdropCarousel_Previews: PreviewProvider {
    static var previews: some View {
        MovieBackdropCarouselView(title: "Ultimo", movies: Movie.stubbedMovies)
    }
}
