//
//  ContentView.swift
//  BirthdayTracker
//
//  Created by Viktor Goleš on 25.11.2022..
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: FriendViewModel = FriendViewModel()
    
    
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            AddFriendView()
                .tabItem {
                    Image(systemName: "plus.circle")
                    Text("Add Friend")
                }
            
            FriendListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("List of Friends")
                }
        }
        .accentColor(.yellow)
        .environmentObject(viewModel)
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            
            UIApplication.shared.applicationIconBadgeNumber = 0
            NotificationManager.instance.requestAuthorizaiton()
            NotificationManager.instance.scheduleNotificatoin()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

