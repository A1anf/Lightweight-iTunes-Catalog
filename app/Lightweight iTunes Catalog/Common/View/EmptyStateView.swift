//
//  EmptyState.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/21/21.
//

import SwiftUI

struct EmptyStateView: View {
    var symbol: SFSymbol
    var symbolColor: Color = .secondary
    var symbolBackgroundColor: Color = .clear
    var text: String
    var textColor: Color = .secondary
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: symbol.rawValue)
                .font(.title)
                .foregroundColor(symbolColor)
                .background(
                    Circle()
                        .fill(symbolBackgroundColor)
                        .frame(width: 60, height: 60)
                )
            
            Text(text)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(textColor)
        }
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView(symbol: .star, text: "No favorites yet")
    }
}
