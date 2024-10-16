//
//  AddMoneyView.swift
//  StepBuckss
//
//   Created by Rohan Prakash on 17/04/24.
//

import SwiftUI

struct AddMoneyView: View {
    
    @EnvironmentObject var Loginviewmodel : loginviewmodel
    @State var showSheet : Bool = false
    @State var money : String = ""
    @Binding var UserEmail : String
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                VStack(alignment: .center){
                    Spacer()
                    TextField("Amount to be added",
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
                                Loginviewmodel.updateItem(person: user, name3: user.name, email3: user.email, steps3: user.steps, pass3: user.pass, wallet3: user.wallet + (Double(money) ?? 0), phone3: user.phone,participating3: user.partcipating)
                                showSheet.toggle()
                            }
                        }
                        
                    } label: {
                        Text("Add to Wallet")
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
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(Color.green)
                    .font(.headline)
                    .padding()
                
            })
        }
        .fullScreenCover(isPresented: $showSheet, content: { ActualView(UserEmail: $UserEmail,selectedTab: 2) })
    }
}

struct AddMoneyView_Previews: PreviewProvider {
    static var previews: some View {
        AddMoneyView(UserEmail: .constant("a"))
            .environmentObject(loginviewmodel())
    }
}
