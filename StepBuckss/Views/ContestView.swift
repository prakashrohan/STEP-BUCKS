//
//  ContestView.swift
//  StepBuckss
//
//  Created by Rohan Prakash on 17/04/24.
//

import SwiftUI

struct ContestView: View {
    
    @Binding var UserEmail : String
    @State var btnText : String = ""
    @EnvironmentObject var Contestviewmodel : contestviewmodel
    @EnvironmentObject var Loginviewmodel : loginviewmodel
    @State var alertTitle : String = ""
    @State var showAlert : Bool = false
    @State var showSheet : Bool = false
    var dateFormatter1: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
    var dateFormatter2: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    var body: some View {
        NavigationStack {
            VStack{
                Text("You can view and enter a contest 2 hours before its start time")
                    .padding()
                    List{
                        ForEach(Contestviewmodel.contestArray) { contest in
                            HStack {
                                VStack(alignment: .leading,spacing: 7){
                                    Text(contest.title)
                                                .font(.title)
                                                .fontWeight(.bold)
                                                Text("Time : \(dateFormatter1.string(from: contest.startTime)) - \(dateFormatter1.string(from: contest.endTime))")
                                        .font(.callout)
                                    Text("Date : \(dateFormatter2.string(from: contest.startTime))")
                                            Text("Entry : ₹ \(String(format: "%.2f", contest.entryFee))")
                                            Text("Max Price Pool : ₹ \(String(format: "%.2f", contest.MaxprizePool))")
                                    Text("Max Participants : \(contest.maxParticipants)")
                                    
                                }
                                ForEach(Loginviewmodel.userDetails) { user in
                                    if user.email == UserEmail{
                                        Button {
                                            if !user.partcipating{
                                                if contest.startTime < Date(){
                                                    if contest.entryTime > Date(){
                                                        alertTitle = "you cannot join the contest after it has ended"
                                                        showAlert.toggle()
                                                    } else {
                                                        alertTitle = "you cannot join the contest after it has started"
                                                        showAlert.toggle()
                                                    }
                                                } else {  
                                                    if user.wallet >= contest.entryFee{
                                                        alertTitle = "₹ \(String(format: "%.2f", contest.entryFee)) has been deducted from your account"
                                                        showAlert.toggle()
                                                        showSheet.toggle()
                                                        Loginviewmodel.updateItem(person: user, name3: user.name, email3: user.email, steps3: user.steps, pass3: user.pass, wallet3: user.wallet - (Double(contest.entryFee) ), phone3: user.phone, participating3: true)
                                                        Contestviewmodel.updateItem(contest: contest, title3: contest.title, startTime3: contest.startTime, endTime3: contest.endTime, entryFee3: contest.entryFee, maxParticipants3: contest.maxParticipants, currentParticipants3: 0, MaxprizePool3: contest.MaxprizePool, multiplierStart3: contest.multiplierStart, multiplierEnd3: contest.multiplierEnd, entryTime3: contest.entryTime, exitTime3: contest.exitTime, CurrentpricePool3:  Double(Loginviewmodel.userDetails.count) * contest.entryFee, rewarded3: false)
                                                    } else {
                                                        alertTitle = "Insufficient Account Balance"
                                                        showAlert.toggle()
                                                    }
                                                }
                                            } else {
                                                showSheet.toggle()
                                            }
                                        } label: {
                                            Text(user.partcipating ? "Show" : "Join ₹\(String(format: "%.2f", contest.entryFee))")
                                                .font(.subheadline)
                                                .foregroundColor(.white)
                                                .frame(width:100,height: 30)
                                                .background(Color.green)
                                                .cornerRadius(20)
                                        }
                                    }
                                }

                            }
                            .sheet(isPresented: $showSheet) {
                                ContestInfoVIew(UserEmail: $UserEmail, contest: contest)
                            }
                        }
                    }
            }
            .alert(isPresented: $showAlert) {
                getAlert()
            }
        }
    }
    func getAlert() -> Alert {
            return Alert(title: Text(alertTitle))
        }
}

struct ContestView_Previews: PreviewProvider {
    static var previews: some View {
        ContestView(UserEmail: .constant("Akshat@gmail.com"))
            .environmentObject(contestviewmodel())
            .environmentObject(loginviewmodel())
    }
}

