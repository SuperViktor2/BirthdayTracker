//
//  HomeView.swift
//  BirthdayTracker
//
//  Created by Viktor Goleš on 25.11.2022..
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel: FriendViewModel
    
    
    var isSecondValid: Bool {
        return viewModel.friends.indices.contains(1)
    }
    
    var isThirdValid: Bool {
        return viewModel.friends.indices.contains(2)
    }
    
    var firstFriend: Friend {
        return viewModel.friends.first!
    }
    
    var secondFriend: Friend {
        return viewModel.friends[1]
    }
    
    var thirdFriend: Friend {
        return viewModel.friends[2]
    }
    
    var dateFormatter: DateFormatter {
           let formatter = DateFormatter()
           formatter.dateStyle = .short
           return formatter
       }
    
    var body: some View {
       // ZStack {
         //   Color(.yellow)
           //     .ignoresSafeArea()
            
            VStack {
                //Spacer()
                Text("Upcoming birthdays:")
                    .font(.largeTitle)
                    .padding(.top, 100.0)
                Spacer()
                
                if viewModel.friends.isEmpty {

                    Text("No friends, go find some!")
                        .font(.largeTitle)
                    
                    Spacer()

                } else {
                    VStack {
                        let today = Calendar.current.dateComponents([.day, .month], from: Date.now)
                        
                        VStack {
                            Text(firstFriend.name ?? "no name")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                            
                            if (viewModel.getDayAndMonth(friend: firstFriend) == today) {
                                Text("Today")
                                    .font(.caption)
                            } else {
                                
                                Text(self.dateFormatter.string(from: firstFriend.bday ?? Date()))
                                    .font(.caption)
                            }
                        }
                        .padding()
                        
                        if isSecondValid{
                            VStack {
                                Text(secondFriend.name ?? "No name")
                                    .font(.title)
                                
                                if (viewModel.getDayAndMonth(friend: secondFriend) == today) {
                                    Text("Today")
                                        .font(.caption)
                                } else {
                                    Text(self.dateFormatter.string(from: secondFriend.bday ?? Date()))
                                        .font(.caption)
                                }
                                
                            }
                            .opacity(0.6)
                            .padding()
                        }
                        
                        if isThirdValid {
                            VStack {
                                Text(thirdFriend.name ?? "No name")
                                if (viewModel.getDayAndMonth(friend: thirdFriend) == today) {
                                    Text("Today")
                                        .font(.caption)
                                } else {
                                    Text(self.dateFormatter.string(from: thirdFriend.bday ?? Date()))
                                        .font(.caption)
                                }
                            }
                            .opacity(0.4)
                            .padding()
                        }
                    }
                    Spacer()
                }
            }
            .onAppear {
                viewModel.sortFriends()
            }
        }
    //}
}

struct HomeView_Previews: PreviewProvider {
    static let viewModel = FriendViewModel()
    static var previews: some View {
        HomeView()
            .environmentObject(viewModel)
    }
}
