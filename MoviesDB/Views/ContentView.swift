//
//  ContentView.swift
//  MoviesDB
//
//  Created by Saksham Shrey on 29/06/24.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var controller = MovieController()
    @State private var selectedOption: MovieOption? = nil
    @State private var selectedValue: String? = nil
    @State private var searchText: String = ""

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, onSearch: {
                    controller.searchMovies(text: searchText)
                }, onClear: {
                    controller.clearSearch()
                })
                List {
                    if searchText.isEmpty {
                        ForEach(MovieOption.allCases, id: \.self) { option in
                            Section(header: HStack {
                                Text(option.rawValue).font(.headline)
                                Spacer()
                                Image(systemName: selectedOption == option ? "chevron.down" : "chevron.right")
                            }
                                    .onTapGesture {
                                        withAnimation {
                                            if selectedOption == option {
                                                selectedOption = nil
                                            } else {
                                                selectedOption = option
                                                selectedValue = nil
                                                controller.clearSearch()
                                            }
                                        }
                            }) {
                                if selectedOption == option {
                                    if option == .allMovies {
                                        ForEach(controller.movies) { movie in
                                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                                MovieRowView(movie: movie)
                                            }
                                        }
                                    } else {
                                        ForEach(controller.getValues(for: option), id: \.self) { value in
                                            VStack(alignment: .leading) {
                                                Text(value)
                                                    .onTapGesture {
                                                        withAnimation {
                                                            if selectedValue == value {
                                                                selectedValue = nil
                                                            } else {
                                                                selectedValue = value
                                                                controller.filterMovies(by: option, value: value)
                                                            }
                                                        }
                                                    }
                                                if selectedValue == value {
                                                    ForEach(controller.filteredMovies) { movie in
                                                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                                                            MovieRowView(movie: movie)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        ForEach(controller.filteredMovies) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie)) {
                                MovieRowView(movie: movie)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Movies")
            .onAppear {
                controller.fetchMovies()
            }
        }
    }
}


enum MovieOption: String, CaseIterable, Identifiable {
    case year = "Year"
    case genre = "Genre"
    case director = "Directors"
    case actors = "Actors"
    case allMovies = "All Movies"

    var id: String { self.rawValue }
}


#Preview {
    ContentView()
}
