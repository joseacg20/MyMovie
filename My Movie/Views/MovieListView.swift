//
//  MovieListView.swift
//  TutorialMovie
//
//  Created by Jose Angel Cortes Gomez on 10/01/21.
//

import SwiftUI

struct MovieListView: View {
    
    @ObservedObject var nowPlayingState = MovieListState()
    @ObservedObject var upcominState = MovieListState()
    @ObservedObject var topRatedSate = MovieListState()
    @ObservedObject var popularSate = MovieListState()
    
    var body: some View {
        NavigationView {
            List {
                Group{
                    if nowPlayingState.movies != nil {
                        MoviePosterCarouselView(title: "En Cartelera", movies: nowPlayingState.movies!)
                    } else {
                        LoadingView(isLoading: nowPlayingState.isLoading, error: nowPlayingState.error) {
                            self.nowPlayingState.loadMovies(with: .nowPlaying)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0))
                
                Group {
                    if upcominState.movies != nil {
                        MovieBackdropCarouselView(title: "Próximas Películas", movies: upcominState.movies!)
                    } else {
                        LoadingView(isLoading: upcominState.isLoading, error: upcominState.error) {
                            self.upcominState.loadMovies(with: .upcoming)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                
                Group {
                    if topRatedSate.movies != nil {
                        MovieBackdropCarouselView(title: "Películas Mejor Calificadas", movies: topRatedSate.movies!)
                    } else {
                        LoadingView(isLoading: topRatedSate.isLoading, error: topRatedSate.error) {
                            self.topRatedSate.loadMovies(with: .topRated)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                
                Group {
                    if popularSate.movies != nil {
                        MovieBackdropCarouselView(title: "Películas Populares", movies: popularSate.movies!)
                    } else {
                        LoadingView(isLoading: popularSate.isLoading, error: popularSate.error) {
                            self.popularSate.loadMovies(with: .popular)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))
            }
            .navigationBarTitle("Peliculas")
        }
        .onAppear {
            self.nowPlayingState.loadMovies(with: .nowPlaying)
            self.upcominState.loadMovies(with: .upcoming)
            self.popularSate.loadMovies(with: .popular)
            self.topRatedSate.loadMovies(with: .topRated)
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieListView()
            MovieListView()
        }
    }
}
