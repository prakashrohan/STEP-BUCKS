//
//  hi.swift
//  StepBucks
//
//   Created by Rohan Prakash on 17/04/24.
//

import SwiftUI
import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

struct SignUpView: View {
   
    @EnvironmentObject var Loginviewmodel : loginviewmodel
    @State var password : String = ""
    @State var phone : String = ""
    @State var name : String = ""
    @State var email : String = ""
    @State var refer : String = ""
    @State var selectedDate : Date = Date()
    @State var showsheet : Bool = false
    @State var alertTitle : String = ""
    @State var showAlert : Bool = false
    let startingDate : Date = Calendar.current.date(from: DateComponents(year: 2023,month: 4)) ?? Date()
    let endingDate : Date = Date()
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack (alignment: .topLeading){
            VStack {
                NavigationStack{
                    ScrollView {
                        VStack(spacing : 40){
                            VStack(alignment: .leading, spacing: 0){
                                Text("Name")
                                    .padding(.leading,25)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                TextField("Name",
                                          text: $name ,
                                          prompt: Text("Enter Name").foregroundColor(.white)
                                    .font(.title3)
                                )
                                .padding(10)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.green, lineWidth: 2)
                                }
                                .padding(.horizontal)
                            }
                            .frame(width: 380)
                            
                            
                            VStack(alignment: .leading, spacing: 0){
                                Text("Email ID")
                                    .padding(.leading,25)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                TextField("Email",
                                          text: $email ,
                                          prompt: Text("Enter Email ID").foregroundColor(.white)
                                    .font(.title3)
                                )
                                .padding(10)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.green, lineWidth: 2)
                                }
                                .padding(.horizontal)
                            }
                            
                            
                            VStack(alignment: .leading, spacing: 0){
                                Text("Password")
                                    .padding(.leading,25)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                TextField("Password",
                                          text: $password ,
                                          prompt: Text("Enter Password").foregroundColor(.white)
                                    .font(.title3)
                                )
                                .padding(10)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.green, lineWidth: 2)
                                }
                                .padding(.horizontal)
                            }
                            .frame(width: 380)
                            
                            VStack(alignment: .leading, spacing: 0){
                                Text("Phone")
                                    .padding(.leading,25)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                TextField("Name",
                                          text: $phone ,
                                          prompt: Text("Enter Phone No.").foregroundColor(.white)
                                    .font(.title3)
                                )
                                .padding(10)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.green, lineWidth: 2)
                                }
                                .padding(.horizontal)
                            }
                            .frame(width: 380)
                            
                            
                            VStack(alignment: .center, spacing: 25){
                                Text("Enter your DOB")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                Spacer(minLength: -40)
                                DatePicker("Select a Date",
                                           selection: $selectedDate,
                                           in: startingDate...endingDate,
                                           displayedComponents: [.date]).datePickerStyle(.graphical)
                                    .accentColor(.green)
                                    .foregroundColor(.green)
                                
                                    .overlay {
                                        Rectangle()
                                            .stroke(Color.green,lineWidth: 2)
                                            .cornerRadius(2)
                                    }
                            }
                            .padding(.horizontal)
                            TextField("Referal Code",
                                      text: $refer ,
                                      prompt: Text("Referal Code").foregroundColor(.white)
                            )
                            .padding(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.green, lineWidth: 2)
                            }
                            .padding(.horizontal)
                        }
                        .padding(50)
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.light)
                        Button {
                            
                                if password != "" && phone != "" && email != "" && name != ""  {
                                    if isValidEmail(emailCheck: email){
                                        var flag = true
                                        for user in Loginviewmodel.userDetails{
                                            if (MD5(string: user.email).map({ String(format: "%02hhx", $0) }).joined() == refer || refer == ""){
                                                if (refer != ""){
                                                    Loginviewmodel.updateItem(person: user, name3: user.name, email3: user.email, steps3: user.steps, pass3: user.pass, wallet3: user.wallet + 10, phone3: user.phone, participating3: user.partcipating)
                                                }
                                                Loginviewmodel.addUser(name: name,email: email, steps: 0, pass: password, wallet: 0, phone: phone)
                                                print("reached")
                                                showsheet.toggle()
                                                flag = false
                                                break
                                            }
                                        }
                                        if (flag) {
                                            showAlert.toggle()
                                            alertTitle = "Invalid Referal"
                                        }

                                        
                                    } else {
                                        showAlert.toggle()
                                        alertTitle = "Invalid Email"
                                    }
                                    
                                } else {
                                    showAlert.toggle()
                                    alertTitle = "Please fill in all Text Fields"
                                }
                        } label: {
                            Text("Submit")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                                .frame(height: 50)
                                .frame(width: 350)
                                .background(Color.green)
                                .cornerRadius(20)
                                .padding()
                        }

                    }
                    .background(Color.black)
                    .navigationBarTitle("Sign Up")
                    .navigationBarTitleDisplayMode(.automatic)
                }
                .fullScreenCover(isPresented: $showsheet, content: {
                    loginView()
                })
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
        .alert(isPresented: $showAlert) {
            getAlert()
        }
    }
    func isValidEmail(emailCheck: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailCheck)
    }
    func getAlert() -> Alert {
            return Alert(title: Text(alertTitle))
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(loginviewmodel())
    }
}


