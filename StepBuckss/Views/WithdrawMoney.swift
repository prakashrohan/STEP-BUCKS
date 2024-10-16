//
//  WithdrawMoney.swift
//  StepBuckss
//
//   Created by Rohan Prakash on 17/04/24.
//

import SwiftUI

struct WithdrawMoney: View {
    @EnvironmentObject var Loginviewmodel : loginviewmodel
    @State var showSheet : Bool = false
    @State var money : String = ""
    @Binding var UserEmail : String
    @State var alertTitle : String = ""
    @State var showAlert : Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                VStack(alignment: .center){
                    Spacer()
                    TextField("Amount to be withdrawn",
                              text: $money ,
                              prompt: Text("Amount to be added").foregroundColor(.green)
                    )
                    .frame(width: 300,height: 50)
                    .padding(.horizontal,10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.green, lineWidth: 2)
                    }
                    .padding(.horizontal)
                    
                    Button {
                        for user in Loginviewmodel.userDetails{
                            if user.email == UserEmail{
                                if user.wallet - (Double(money) ?? 0) >= 0 {
                                    Loginviewmodel.updateItem(person: user, name3: user.name,  email3: user.email, steps3: user.steps, pass3: user.pass, wallet3: user.wallet - (Double(money) ?? 0), phone3: user.phone, participating3: user.partcipating)
                                    showSheet.toggle()
                                } else {
                                    showAlert.toggle()
                                    alertTitle = "Insufficient Balance"
                                }
                            }
                        }         
                    } label: {
                        Text("Withdraw from Wallet")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 250,height: 50)
                            .background(Color.green)
                            .cornerRadius(50)
                            .padding()
                    }
                    Spacer()
                }
            }
            .alert(isPresented: $showAlert) {
                getAlert()
            }
            Button(action: {
                presentationMode.wrappedValue.dismiss()
                //    remember this syntax
                //the sheet can also be removed by holding and scrolling it down
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(Color.green)
                    .font(.headline)
                    .padding()
                
            })
        }
        .fullScreenCover(isPresented: $showSheet, content: { ActualView(UserEmail: $UserEmail,selectedTab: 2) })
    }
    func getAlert() -> Alert {
            return Alert(title: Text(alertTitle))
        }
}

struct WithdrawMoney_Previews: PreviewProvider {
    static var previews: some View {
        WithdrawMoney(UserEmail: .constant("a"))
            .environmentObject(loginviewmodel())
    }
}
