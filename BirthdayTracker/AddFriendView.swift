//
//  AddFriendView.swift
//  BirthdayTracker
//
//  Created by Viktor Goleš on 25.11.2022..
//

import SwiftUI
import Combine

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct AddFriendView: View {
    
    @EnvironmentObject var viewModel: FriendViewModel
    
    @State var input: String = ""
    @State var date: Date = Date()
    
    @ObservedObject var textBindingManager = TextBindingManager(limit: 20)
    
    @State private var alert = false
    @State private var added = false
    
    //let textLimit = 20
    
    var body: some View {
        VStack {
            Spacer()
            Text("🎉 Friend added! 🎉")
                .font(.largeTitle)
                .opacity(added ? 1.0 : 0.0)
                .animation(
                    .easeInOut(duration: 1),
                    value: added
                )
            
            TextField("Enter name", text: $textBindingManager.text)
                .foregroundColor(.yellow)
                .padding(.all)
                .multilineTextAlignment(.center)
                .disableAutocorrection(true)
                .font(.largeTitle)
                //.onReceive(Just(input)) { _ in self.viewModel.limitText(input: input, textLimit) }
                .onTapGesture {
                  self.hideKeyboard()
                }
            Text("was born on a date")
                .font(.title)
                .foregroundColor(.yellow)
            
            DatePicker(
                "",
                selection: $date,
                in: ...Date(),
                displayedComponents: .date
            )
                .labelsHidden()
                .datePickerStyle(.wheel)
            
            Spacer()
            
            Button("Save birthday") {
    
                if  textBindingManager.text == "" {
                    let impactMed = UIImpactFeedbackGenerator(style: .rigid)
                    impactMed.impactOccurred()
                    self.alert.toggle()
                } else {
                    let impactMed = UIImpactFeedbackGenerator(style: .light)
                    impactMed.impactOccurred()
                    viewModel.addFriend(name: textBindingManager.text, birthday: date)
                    textBindingManager.text = ""
                    self.added.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.added.toggle()
                    }
                }
            }
            .alert(isPresented: $alert) {
                Alert(
                    title: Text("Please enter name"),
                    dismissButton: .default(Text("Got it!"))
                )
            }
            .padding(.all, 20)
            .accentColor(.white)
            .background(Color.yellow)
            .cornerRadius(10)
            
            Spacer()
        }
    }
}

struct AddFriendView_Previews: PreviewProvider {
    static var previews: some View {
        AddFriendView()
    }
}
