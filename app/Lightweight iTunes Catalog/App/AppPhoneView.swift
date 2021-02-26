//
//  AppPhoneView.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/21/21.
//

import SwiftUI

struct AppPhoneView: View {
    var body: some View {
        NavigationView {
            HomeView(viewModel: HomeViewModel())
                .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AppPhoneView_Previews: PreviewProvider {
    static var previews: some View {
        AppPhoneView()
    }
}
