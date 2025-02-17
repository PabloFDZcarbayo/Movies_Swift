//
//  Pelicula.swift
//  Tarea02
//
//  Created by Pablo fernandez on 14/10/24.
//

import Foundation

struct Pelicula: Identifiable, Decodable {
    let id: Int
    let title: String
    let overview: String
    let genreIds: [Int]
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
    let originalLanguage: String
    let popularity: Double
    
    // Mapeo de nombres de las claves JSON de TMDB
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case genreIds = "genre_ids"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originalLanguage = "original_language"
        case popularity
    }
    
    // Computed property para obtener la URL completa del póster
    var posterURL: String {
        return "https://image.tmdb.org/t/p/w500\(posterPath ?? "")"
    }

    // Computed property para obtener la URL de la imagen de fondo
    var backdropURL: String {
        return "https://image.tmdb.org/t/p/w780\(backdropPath ?? "")"
    }
}

