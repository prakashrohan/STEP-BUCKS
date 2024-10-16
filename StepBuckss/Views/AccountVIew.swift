//
//  Account View.swift
//  StepBucks
//
//  Created by Rohan Prakash on 17/04/24.
//

import SwiftUI
import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

struct Account_View: View {
    @EnvironmentObject var Loginviewmodel : loginviewmodel
    @Binding var UserEmail : String
    @State var LogOutAccess : Bool = false
    @State var EditAccess : Bool = false
    @State var txt : String = ""
    private let pasteboard = UIPasteboard.general
    var body: some View {
        VStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 300,height: 300)
                .foregroundColor(.green)
            Spacer()
            List{
                ForEach(Loginviewmodel.userDetails) { user in
                    if user.email == UserEmail {
                        Text("Email ID - \(user.email)")
                        Text("Name - \(user.name)")
                        Text("Phone - \(user.phone)")
                        
                    }
                }
            }
            ForEach(Loginviewmodel.userDetails) { user in
                if user.email == UserEmail{
                    VStack(alignment:.center ,spacing: 30) {
                        Text("Refer a friend to get ₹10 bonus")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.top)
                        ZStack(alignment: .trailing){
                            Color.gray
                            TextField("text", text: .constant("\(MD5(string: user.email).map { String(format: "%02hhx", $0) }.joined())"))
                                .font(.subheadline)
                                .disabled(true)
                                .padding()
                            Button {
                                txt = String("\(MD5(string: user.email).map { String(format: "%02hhx", $0) }.joined())")
                                copyToClipboard()
                            } label: {
                                Image(systemName: "doc.on.doc.fill")
                                    .frame(width: 20, height: 25)
                                    .foregroundColor(.white)
                            }
                            .padding(.trailing,15)
                        }
                        .frame( height: 20)
                    }
                    .background(Color.gray.opacity(0.4))
                }
            }
            HStack {
                Button {
                    EditAccess.toggle()
                } label: {
                    Text("Edit Account")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(20)
                        .padding()
            }
                Button {
                    LogOutAccess = true
                } label: {
                    Text("Log Out")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(20)
                        .padding()
                }
            }
            Spacer()
        }
        .fullScreenCover(isPresented: $LogOutAccess) {
            loginView()
        }
        .sheet(isPresented: $EditAccess) {
            EditAccountView(UserEmail: $UserEmail)
        }
    }
    
    func copyToClipboard(){
        pasteboard.string = self.txt
    }
    func MD5(string: String) -> Data {
            let length = Int(CC_MD5_DIGEST_LENGTH)
            let messageData = string.data(using:.utf8)!
            var digestData = Data(count: length)

            _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
                messageData.withUnsafeBytes { messageBytes -> UInt8 in
                    if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                        let messageLength = CC_LONG(messageData.count)
                        CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                    }
                    return 0
                }
            }
            return digestData
        }
}

struct Account_View_Previews: PreviewProvider {
    static var previews: some View {
        Account_View(UserEmail : .constant("Akshat@gmail.com"))
            .environmentObject(loginviewmodel())
    }
}
