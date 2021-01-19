//
//  MovieService.swift
//  My Movie
//
//  Created by Jose Angel Cortes Gomez on 10/01/21.
//

import Foundation

protocol MovieService {
    
    func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ())
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
}

enum MovieListEndpoint: String, CaseIterable, Identifiable {
    
    var id: String { rawValue }
    
    case nowPlaying = "now_playing"
    case upcoming = "upcoming"
    case topRated = "top_rated"
    case popular = "popular"
    
    var description: String {
        switch self {
            case .nowPlaying: return "Películas en Cartelera"
            case .upcoming: return "Próximas Películas"
            case .topRated: return "Películas Mejor Calificadas"
            case .popular: return "Popular"
        }
    }
}

enum MovieError: Error, CustomNSError {
    
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "No se pudieron recuperar los datos"
        case .invalidEndpoint: return "Punto final no válido"
        case .invalidResponse: return "Respuesta invalida"
        case .noData: return "Sin datos"
        case .serializationError: return "Error al decodificar los datos"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}
