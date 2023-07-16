//
//  FriendViewModel.swift
//  BirthdayTracker
//
//  Created by Viktor Goleš on 25.11.2022..
//

import Foundation
import CoreData

class FriendViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    
    @Published var friends: [Friend] = []
    
    init () {
        container = NSPersistentContainer(name: "FriendsContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading core data: \(error)")
            }
        }
        
        fetchFriends()
        sortFriends()
    }
    
    func getDayAndMonth (friend: Friend) -> DateComponents {
        let date = Calendar.current.dateComponents([.day, .month], from: friend.bday ?? Date.now)
        return date
    }
    
    func getDateOfBirthInCurrentYear(friend: Friend) -> Date? {
        let calendar = Calendar.current

        return calendar.nextDate(
            after: .init() - 86400,
            matching: calendar.dateComponents([.day, .month],
            from: friend.bday ?? Date.now), matchingPolicy: .nextTime
        )
    }
    
    func sortFriends() {
        friends = friends.sorted {
            getDateOfBirthInCurrentYear(friend: $0) ?? Date.now <= getDateOfBirthInCurrentYear(friend: $1) ?? Date.now
        }
    }
    
    func fetchFriends() {
        let request = NSFetchRequest<Friend>(entityName: "Friend")
        
        do {
            friends = try container.viewContext.fetch(request)
            sortFriends()
        } catch let error {
            print("Error fetching... \(error)")
        }
        
    }
    
    func addFriend (name: String, birthday: Date) {
        let newFriend = Friend(context: container.viewContext)
        newFriend.name = name
        newFriend.bday = birthday
        saveData()
    }
    
    func saveData () {
        do {
            try container.viewContext.save()
            fetchFriends()
        } catch let error {
            print("Error saving. \(error)")
        }
        
    }
    
    func deleteFriend(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let friend = friends[index]
        container.viewContext.delete(friend)
        saveData()
    }
}
