//
//  WalletView.swift
//  StepBuckss
//
//   Created by Rohan Prakash on 17/04/24.
//

import SwiftUI

struct WalletView: View {
    
    @EnvironmentObject var Loginviewmodel : loginviewmodel
    @State var showSheet1: Bool = false
    @State var showSheet2: Bool = false
    @Binding var UserEmail : String
    @State var WalletMoney : Double = 0
    
    var body: some View {
        VStack(spacing: 30){
            Image(systemName: "building.columns")
                .resizable()
                .frame(width: 200,height: 200)
                .aspectRatio(contentMode: .fill)
                .foregroundColor(.green)
            
            VStack(spacing : 15) {
                Text("Your current Wallet balance is : ")
                    .font(.title)
//                    .font(.callout)
                    .fontWeight(.bold)
                .multilineTextAlignment(.center)
                HStack {
                    
                    Image(systemName: "indianrupeesign")
                    Text("\( String(format: "%.2f", WalletMoney))")
                }
                .font(.largeTitle)
                .fontWeight(.bold)
            .multilineTextAlignment(.center)
            }
            .onAppear(){
                for user in Loginviewmodel.userDetails{
                    if user.email == UserEmail{
                        WalletMoney = user.wallet
                    }
                }
            }
            HStack {
                    Button {
                        showSheet1.toggle()
                    } label: {
                        Text("Add")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(20)
                            .padding()
                    }
                
                Button {
                    showSheet2.toggle()
                } label: {
                    Text("Withdraw")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(20)
                        .padding()
                }
            }
        }
        .sheet(isPresented: $showSheet1, content: { AddMoneyView(UserEmail: $UserEmail) })
        .sheet(isPresented: $showSheet2) {
            WithdrawMoney(UserEmail: $UserEmail)
        }
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView(UserEmail: .constant("a"))
            .environmentObject(loginviewmodel())
    }
}


