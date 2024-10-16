//
//  StepBuckssApp.swift
//  StepBuckss
//
//   Created by Rohan Prakash on 17/04/24.
//

import SwiftUI

@main
struct StepBuckssApp: App {
    
    @State private var vm = LocationsViewModel()
    @StateObject var Homeviewmodel : homeviewmodel = homeviewmodel()
    @StateObject var LoginViewModel : loginviewmodel = loginviewmodel()
    @StateObject var Contestviewmodel : contestviewmodel = contestviewmodel()
    
    var body: some Scene {
        WindowGroup {
            loginView()
                .environmentObject(loginviewmodel())
                .environmentObject(homeviewmodel())
                .environmentObject(contestviewmodel())
                .environmentObject(vm)
        }
    }
}
