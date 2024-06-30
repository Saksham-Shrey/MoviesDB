//
//  MovieDetailView.swift
//  MoviesDB
//
//  Created by Saksham Shrey on 29/06/24.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @State private var selectedRatingSource: String = "IMDB"
    
    var body: some View {
        VStack {
            ScrollView {
            if let url = URL(string: movie.poster) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 200, height: 300)
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 200, height: 300)
                    case .failure:
                        Image(systemName: "exclamationmark.triangle.fill")
                            .resizable()
                            .frame(width: 200, height: 300)
                    default:
                        EmptyView()
                    }
                }
            }
            Text(movie.title)
                .font(.title)
                .padding()
            Text(movie.plot)
                .padding()
                
                Text("Released: \(movie.released)")
                    .padding()
                Text("Genre: \(movie.genre)")
                    .padding()
                Text("Cast: \(movie.actors)")
                    .padding()
                Text("Crew - ")
                    .bold()
                Text("Director: \(movie.director)")
                    .padding()
                Text("Writer: \(movie.writer)")
                    .padding()
                Text("Producer: \(movie.production ?? "NA")")
                    .padding()
                
            }
            Picker("Rating Source", selection: $selectedRatingSource) {
                Text("IMDB").tag("IMDB")
                Text("Rotten Tomatoes").tag("Rotten Tomatoes")
                Text("Metacritic").tag("Metacritic")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            Text("Rating: \(getRating(for: selectedRatingSource))")
                .font(.headline)
        }
        .navigationTitle(movie.title)
    }
    
    func getRating(for source: String) -> String {
        if let rating = movie.ratings.first(where: { $0.source == source }) {
            return rating.value
        } else {
            return "N/A"
        }
    }
}

