//
//  FriendListView.swift
//  BirthdayTracker
//
//  Created by Viktor Goleš on 25.11.2022..
//

import SwiftUI

struct FriendListView: View {
    
    @EnvironmentObject var viewModel: FriendViewModel
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    var body: some View {
        VStack {
            
            Text("Friends").font(.headline)
            
            if viewModel.friends.isEmpty {
                
                Spacer()
                
                Text("No friends yet")
                    .font(.largeTitle)
                
                Spacer()
                
            } else {
                
                List {
                    ForEach(viewModel.friends) { friend in
                        HStack {
                            
                            let today = Calendar.current.dateComponents([.day, .month], from: Date.now)
                            
                            Text(friend.name ?? "No name")
                            Spacer()
                            
                            if (viewModel.getDayAndMonth(friend: friend) == today) {
                                Text("Today")
                            } else {
                                Text(self.dateFormatter.string(from: friend.bday ?? Date()))
                            }
                            
                        }
                    }
                    .onDelete (perform: viewModel.deleteFriend)
                }
                .listStyle(.plain)
                
            }
        }
        .onAppear {
            
           /* for friend in viewModel.friends {
                print(viewModel.getDateOfBirthInCurrentYear(friend: friend) ?? Date())
            } */
            
            viewModel.sortFriends()
        }
    }
}


struct FriendListView_Previews: PreviewProvider {
    static let viewModel = FriendViewModel()
    static var previews: some View {
        FriendListView()
            .environmentObject(viewModel)
    }
}
