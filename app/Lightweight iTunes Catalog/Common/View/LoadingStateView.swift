//
//  LoadingStateView.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/21/21.
//

import SwiftUI

struct LoadingStateView: View {
    var text: String?
    
    var body: some View {
        if let text = text, !text.isEmpty {
            ProgressView(text)
                .foregroundColor(.secondary)
        } else {
            ProgressView()
                .foregroundColor(.secondary)
        }
    }
}

struct LoadingStateView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingStateView(text: "Loading")
    }
}
