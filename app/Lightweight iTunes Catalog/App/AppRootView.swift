//
//  AppRootView.swift
//  Lightweight iTunes Catalog
//
//  Created by Carl Funk on 2/21/21.
//

import SwiftUI

struct AppRootView: View {
    var body: some View {
        if Device.isPhone {
            AppPhoneView()
        } else {
            #warning("Implement an iPad View")
            AppPhoneView()
        }
    }
}

struct AppRootView_Previews: PreviewProvider {
    static var previews: some View {
        AppRootView()
    }
}
