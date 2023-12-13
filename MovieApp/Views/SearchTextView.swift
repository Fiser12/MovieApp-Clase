//
//  SearchTextView.swift
//  MovieApp
//
//  Created by Rubén García on 13/12/23.
//

import SwiftUI

struct SearchTextView: View {
    @Binding var searchText: String
    
    var body: some View {
        ZStack {
            TextField("Buscar", text: $searchText)
                .padding(12)
                .padding(.horizontal, 30)
                .background(.thickMaterial)
                .cornerRadius(8)
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 8)
                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 8)

                }
            }
        }
    }
}

#Preview {
    struct TemporalView: View {
        @State var text = ""
        
        var body: some View {
            SearchTextView(searchText: $text)
        }
    }
    return TemporalView()
}
