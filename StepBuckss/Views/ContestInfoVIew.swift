//
//  ContestInfoVIew.swift
//  StepBuckss
//
//   Created by Rohan Prakash on 17/04/24.
//

import SwiftUI

struct ContestInfoVIew: View {
    
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    @State var first : Int = 0
    @State var second : Int = 0
    @State var third : Int = 0
    @State var alertTitle : String = ""
    @State var showAlert : Bool = false
    @Binding var UserEmail : String
    @State var contest : ContestModel
    @EnvironmentObject var Loginviewmodel : loginviewmodel
    @EnvironmentObject var Contestviewmodel : contestviewmodel
    @State var pos : Int = 1
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack(alignment: .topLeading){
            VStack(alignment: .center) {
                Group{
                    VStack(spacing: 10){
                        Text("Note : ")
                        HStack {
                            Text("1.")
                                .font(.title)
                            Spacer()
                            Text("If there is a tie between participants,the partipant who joined the earliest will get a higher position.")
                                .font(.subheadline)
                                .frame(width: 340)
                                .fontWeight(.semibold)
                        }
                        Divider()
                        HStack {
                            Text("2.")
                                .font(.title)
                            Spacer()
                            Text("Your steps can be tracked from \(dateFormatter.string(from: contest.startTime)) to \(dateFormatter.string(from: contest.endTime)) only.")
                                .font(.subheadline)
                                .frame(width: 340)
                                .fontWeight(.semibold)
                        }
                        Divider()
                        HStack {
                            Text("3.")
                                .font(.title)
                            Spacer()
                            Text("Multiplier time interval :- \(dateFormatter.string(from: contest.multiplierStart)) to \(dateFormatter.string(from: contest.multiplierEnd))")
                                .font(.subheadline)
                                .frame(width: 340)
                                .fontWeight(.semibold)
                        }
                        Divider()
                        HStack{
                            Text("4.")
                                .font(.title)
                            Spacer()
                            Text("Prize pool might change according to the number of participating users")
                                .font(.subheadline)
                                .frame(width: 340)
                                .fontWeight(.semibold)
                        }
                    }
                }
                .frame(height: 325)
                .padding(.horizontal,1)
                .multilineTextAlignment(.center)
                List{
                    ForEach(Loginviewmodel.userDetails){users in
                            HStack{
                                Text(users.name)
                                Text("\(users.steps)")
                                Spacer(minLength: 25)
                                if users.email == UserEmail {
                                    if Date()>=contest.startTime && Date()<=contest.endTime{
                                        if Date()>=contest.startTime && Date()<=contest.endTime{
                                            Button {
                                                if Date()>=contest.multiplierStart && Date()<=contest.multiplierEnd{
                                                    Loginviewmodel.updateItem(person: users, name3: users.name, email3: users.email, steps3: users.steps + 2, pass3: users.pass, wallet3: users.wallet, phone3: users.phone, participating3: users.partcipating)
                                                } else {
                                                    Loginviewmodel.updateItem(person: users, name3: users.name, email3: users.email, steps3: users.steps + 1, pass3: users.pass, wallet3: users.wallet, phone3: users.phone, participating3: users.partcipating)
                                                }
                                                
                                            } label: {
                                                Text("+")
                                                    .frame(maxWidth: .infinity)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                }
                VStack(alignment: .leading){
                    if Date()>contest.endTime{
                        Text("Standings : ")
                        Text("1. \(Loginviewmodel.userDetails[0].name) - ₹ \(String(format: "%.2f", contest.CurrentpricePool * 0.45 ))")
                        Text("2. \(Loginviewmodel.userDetails[1].name) - ₹ \(String(format: "%.2f", contest.CurrentpricePool * 0.30 ))")
                        Text("3. \(Loginviewmodel.userDetails[2].name) - ₹ \(String(format: "%.2f", contest.CurrentpricePool * 0.20 ))")
                    }
                }
            }
            .onAppear(){
                if Date() < contest.startTime && Date() > contest.entryTime{
                    for user in Loginviewmodel.userDetails{
                        Loginviewmodel.updateItem(person: user, name3: user.name, email3: user.email, steps3: 0, pass3: user.pass, wallet3: user.wallet, phone3: user.phone, participating3: user.partcipating)
                    }
                }
            }
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(Color.green)
                    .font(.headline)
                    .padding()
                
            })

            .alert(isPresented: $showAlert) {
                getAlert()
            }
            
        }
        .onReceive(timer) { value in
            if Date() > contest.endTime && contest.rewarded == false{
                Contestviewmodel.updateItem(contest: contest, title3: contest.title, startTime3: contest.startTime, endTime3: contest.endTime, entryFee3: contest.entryFee, maxParticipants3: contest.maxParticipants, currentParticipants3: 1, MaxprizePool3: contest.MaxprizePool, multiplierStart3: contest.multiplierStart, multiplierEnd3: contest.multiplierEnd, entryTime3: contest.entryTime, exitTime3: contest.exitTime, CurrentpricePool3: contest.CurrentpricePool, rewarded3: true)
                Loginviewmodel.updateItem(person: Loginviewmodel.userDetails[0], name3: Loginviewmodel.userDetails[0].name, email3: Loginviewmodel.userDetails[0].email, steps3: Loginviewmodel.userDetails[0].steps, pass3: Loginviewmodel.userDetails[0].pass, wallet3: Loginviewmodel.userDetails[0].wallet + (Double(contest.CurrentpricePool * 0.45) ), phone3: Loginviewmodel.userDetails[0].phone, participating3: Loginviewmodel.userDetails[0].partcipating)
                
                Loginviewmodel.updateItem(person: Loginviewmodel.userDetails[1], name3: Loginviewmodel.userDetails[1].name, email3: Loginviewmodel.userDetails[1].email, steps3: Loginviewmodel.userDetails[1].steps, pass3: Loginviewmodel.userDetails[1].pass, wallet3: Loginviewmodel.userDetails[1].wallet + (Double(contest.CurrentpricePool * 0.30) ), phone3: Loginviewmodel.userDetails[1].phone, participating3: Loginviewmodel.userDetails[1].partcipating)
                
                Loginviewmodel.updateItem(person: Loginviewmodel.userDetails[2], name3: Loginviewmodel.userDetails[2].name, email3: Loginviewmodel.userDetails[2].email, steps3: Loginviewmodel.userDetails[2].steps, pass3: Loginviewmodel.userDetails[2].pass, wallet3: Loginviewmodel.userDetails[2].wallet + (Double(contest.CurrentpricePool * 0.20) ), phone3: Loginviewmodel.userDetails[2].phone, participating3: Loginviewmodel.userDetails[2].partcipating)
                for user in Loginviewmodel.userDetails{
                    if user.email == UserEmail{
                            if Loginviewmodel.userDetails[0] == user{
                                alertTitle = "Congratulations! You won ₹ \(String(format: "%.2f", contest.CurrentpricePool * 0.45))"
                                showAlert.toggle()
                            }
                            if Loginviewmodel.userDetails[1] == user{
                                alertTitle = "Congratulations! You won ₹ \(String(format: "%.2f", contest.CurrentpricePool * 0.30))"
                                showAlert.toggle()
                            }
                            if Loginviewmodel.userDetails[2] == user{
                                alertTitle = "Congratulations! You won ₹ \(String(format: "%.2f", contest.CurrentpricePool * 0.20))"
                                showAlert.toggle()
                            }
                    }
                }
            }
        }
    }
    func getAlert() -> Alert {
            return Alert(title: Text(alertTitle))
        }
}

struct ContestInfoVIew_Previews: PreviewProvider {
    static var previews: some View {
        ContestInfoVIew(UserEmail: .constant("Assh@gmail.com"), contest: ContestModel(title: "no.1", startTime: Calendar.current.date(from: DateComponents(year: 2023,day: 113,hour: 9)) ?? Date(), endTime: Calendar.current.date(from: DateComponents(year: 2023,day: 114,hour: 10)) ?? Date(), entryFee: 5, maxParticipants: 10, currentParticipants: 2,MaxprizePool: 47.5 ,multiplierStart: Calendar.current.date(from: DateComponents(year: 2023,day: 113,hour: 10, minute: 30)) ?? Date(), multiplierEnd: Calendar.current.date(from: DateComponents(year: 2023,day: 114,hour: 10, minute: 40)) ?? Date(),entryTime: Calendar.current.date(from: DateComponents(year: 2023,day: 111,hour: 8)) ?? Date(),exitTime: Calendar.current.date(from: DateComponents(year: 2023,day: 115,hour: 10,minute: 30)) ?? Date(), CurrentpricePool: 1, rewarded: false))
            .environmentObject(contestviewmodel())
            .environmentObject(loginviewmodel())
    }
}
//Text(dateFormatter.string(from: startingDate1))
