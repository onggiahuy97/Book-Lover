//
//  NavigationView.swift
//  Book Lover Fix
//
//  Created by Huy Ong on 7/15/20.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "book")
                    Text("Home")
                }
            
            SettingViews() // Setup changeable for accent color
                .tabItem {
                    Image(systemName: "gear")
                    Text("Setting")
                }
        }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
