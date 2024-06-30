//
//  MovieRowView.swift
//  MoviesDB
//
//  Created by Saksham Shrey on 29/06/24.
//

import SwiftUI

struct MovieRowView: View {
    let movie: Movie

    var body: some View {
        HStack {
            if let url = URL(string: movie.poster) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 50, height: 75)
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 50, height: 75)
                            .scaledToFit()
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 50, height: 75)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            VStack(alignment: .leading) {
                Text(movie.title)
                Text("Language: \(movie.language)")
                    .font(.caption)
                Text("Year: \(movie.year)")
                    .font(.caption)
            }
        }
    }
}

//
//#Preview {
//    MovieRowView()
//}
