//
//  MainTabView.swift
//  Spliter
//
//  Created by Vikas Salian on 20/10/24.
//

import SwiftUI

struct MainView: View {

    @State private var selectedIndex: Int = 0

    var body: some View {
        TabView(selection: $selectedIndex) {
            
            NavigationView {
                Text("Currency")
                    .navigationTitle("Home")
            }
            .tabItem {
                Text("Currency")
                Image(systemName: "house.fill")
                    .renderingMode(.template)
            }
            .tag(0)
            
            NavigationView {
                Text("Groups")
                    .navigationTitle("Home")
            }
            .tabItem {
                Text("Groups")
                Image(systemName: "house.fill")
                    .renderingMode(.template)
            }
            .tag(1)

            NavigationView {
                Text("Profile")
                    .navigationTitle("Profile")
            }
            .tabItem {
                Label("Profile", systemImage: "person.fill")
            }
            .tag(2)

//            NavigationView {
//                Text("About view")
//                    .navigationTitle("About")
//
//            }
//            .tabItem {
//                Text("About view")
//                Image(systemName: "info.circle")
//            }
//            .badge("12")
//            .tag(2)
        }
        // 1
        .tint(.pink)
        .onAppear(perform: {
            // 2
            UITabBar.appearance().unselectedItemTintColor = .systemBrown
            // 3
            UITabBarItem.appearance().badgeColor = .systemPink
            // 4
            UITabBar.appearance().backgroundColor = .systemGray4.withAlphaComponent(0.4)
            // 5
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.systemPink]
            // UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
            // Above API will kind of override other behaviour and bring the default UI for TabView
        })
    }
}

#Preview {
    MainView()
}
