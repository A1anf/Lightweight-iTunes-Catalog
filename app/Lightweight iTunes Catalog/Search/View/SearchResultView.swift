//
//  SearchResultView.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/21/21.
//

import SwiftUI

struct SearchResultView<Header: View>: View {
    @StateObject var viewModel: SearchResultViewModel

    var header: ( () -> Header )? = nil

    var body: some View {
        List {
            header?()

            ForEach(viewModel.availableTypeSections, id: \.self.rawValue) { sectionMediaType in
                
                VStack(alignment: .leading) {
                    Text(viewModel.title(for: sectionMediaType))
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: [GridItem()], alignment: .top, spacing: 20) {
                            ForEach(viewModel.results(for: sectionMediaType), id: \.id) { searchResult in
                                SearchResultRowView(viewModel: SearchResultRowViewModel(searchResult: searchResult))
                            }
                        }
                        .frame(height: 200)
                    }
                }
                
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView<EmptyView>(viewModel: SearchResultViewModel(results: [:]))
    }
}
