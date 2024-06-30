//
//  Searchbar.swift
//  MoviesDB
//
//  Created by Saksham Shrey on 29/06/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onSearch: () -> Void
    var onClear: () -> Void

    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onChange(of: text) { oldValue, newValue in
                    onSearch()
                }
            if !text.isEmpty {
                Button(action: {
                    text = ""
                    onClear()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .padding(10)
                }
            }
        }
    }
}
