//
//  MovieViewModel.swift
//  MoviesDB
//
//  Created by Saksham Shrey on 29/06/24.
//

import Foundation

class MovieController: ObservableObject {
    var movies: [Movie] = []
    var filteredMovies: [Movie] = []
    
    init() {
        fetchMovies()
    }
    
    func fetchMovies() {
        guard let url = Bundle.main.url(forResource: "movies", withExtension: "json") else {
            print("Movies JSON file not found")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            movies = try JSONDecoder().decode([Movie].self, from: data)
            filteredMovies = movies
        } catch {
            print("Error fetching movies: \(error)")
        }
    }
    
    func getValues(for option: MovieOption) -> [String] {
        switch option {
        case .year:
            return Array(Set(movies.map { $0.year })).sorted()
        case .genre:
            return Array(Set(movies.flatMap { $0.genre.components(separatedBy: ", ") })).sorted()
        case .director:
            return Array(Set(movies.map { $0.director })).sorted()
        case .actors:
            return Array(Set(movies.flatMap { $0.actors.components(separatedBy: ", ") })).sorted()
        case .allMovies:
            return []
        }
    }
    
    func filterMovies(by option: MovieOption, value: String) {
        switch option {
        case .year:
            filteredMovies = movies.filter { $0.year == value }
        case .genre:
            filteredMovies = movies.filter { $0.genre.contains(value) }
        case .director:
            filteredMovies = movies.filter { $0.director == value }
        case .actors:
            filteredMovies = movies.filter { $0.actors.contains(value) }
        case .allMovies:
            filteredMovies = movies
        }
    }
    
    func searchMovies(text: String) {
        guard !text.isEmpty else {
            filteredMovies = movies
            return
        }
        
        let searchTerm = text.lowercased()
        filteredMovies = movies.filter {
            $0.title.lowercased().contains(searchTerm) ||
            $0.genre.lowercased().contains(searchTerm) ||
            $0.actors.lowercased().contains(searchTerm) ||
            $0.director.lowercased().contains(searchTerm)
        }
    }
    
    func clearSearch() {
        filteredMovies = movies
    }
}
