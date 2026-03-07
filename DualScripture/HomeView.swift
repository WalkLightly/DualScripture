//
//  ContentView.swift
//  DualScripture
//
//  Created by Michael Knight on 1/14/26.
//

import SwiftUI
import Foundation
import SwiftSoup



struct HomeView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: VersesView()) {
                Text("View verses")
            }
        }
    }
}

#Preview {
    HomeView()
}
