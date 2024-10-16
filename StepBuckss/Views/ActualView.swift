//
//  mainView.swift
//  StepBucks
//
//   Created by Rohan Prakash on 17/04/24.
//

import SwiftUI

struct ActualView: View {
    
    @EnvironmentObject var vm : LocationsViewModel
    @EnvironmentObject var Loginviewmodel : loginviewmodel
    @EnvironmentObject var Homeviewmodel : homeviewmodel
    @EnvironmentObject var Contestviewmodel : contestviewmodel
    @Binding var UserEmail : String
    @State var selectedTab : Int = 0
    var body: some View {
        
        TabView(selection: $selectedTab){
            HomeView(UserEmail: $UserEmail)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }.tag(0)
            
//            Text("This is visible in page 2")
            ContestView(UserEmail: $UserEmail)
                .tabItem {
                    Image(systemName: "shoeprints.fill")
                    Text("Contests")
                }.tag(1)

            WalletView(UserEmail: $UserEmail)
                .tabItem {
                    Image(systemName: "indianrupeesign.circle.fill")
                    Text("Wallet")
                }.tag(2)
            
            LocationsView()
                .tabItem {
                    Image(systemName: "globe")
                    Text("Maps")
                }.tag(3)
            
            Account_View(UserEmail: $UserEmail)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Account")
                }.tag(4)
            
            
        }
        .accentColor(.green)
        .navigationBarBackButtonHidden(true)
    }
    
}

struct mainView_Previews: PreviewProvider {
    static var previews: some View {
        ActualView(UserEmail: .constant("a"))
            .environmentObject(loginviewmodel())
            .environmentObject(homeviewmodel())
            .environmentObject(contestviewmodel())
            .environmentObject(LocationsViewModel())
    }
}

