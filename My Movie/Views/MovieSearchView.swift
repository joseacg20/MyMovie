//
//  MovieSearchView.swift
//  TutorialMovie
//
//  Created by Jose Angel Cortes Gomez on 10/01/21.
//

import SwiftUI

struct MovieSearchView: View {
    @ObservedObject var movieSearchSate = MovieSearchState()
    
    var body: some View {
        NavigationView {
            List {
                SearchBarView(placheholder: "Buscar Pelicula", text: self.$movieSearchSate.query)
                    .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                
                LoadingView(isLoading: self.movieSearchSate.isLoading, error: self.movieSearchSate.error) {
                    self.movieSearchSate.search(query: self.movieSearchSate.query)
                }
                
                if self.movieSearchSate.movies != nil {
                    ForEach(self.movieSearchSate.movies!) { movie in
                        NavigationLink(
                            destination: MovieDetailView(movieId: movie.id)) {
                            VStack(alignment: .leading) {
                                Text(movie.title)
                                Text(movie.yearText)
                            }
                        }
                    }
                }
            }
            .onAppear {
                self.movieSearchSate.startObserve()
            }
            .navigationBarTitle("Buscar")
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
