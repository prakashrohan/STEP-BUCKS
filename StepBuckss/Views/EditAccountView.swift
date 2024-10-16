//
//  EditAccountView.swift
//  StepBucks
//
//   Created by Rohan Prakash on 17/04/24.
//

import SwiftUI

struct EditAccountView: View {
    @EnvironmentObject var Homeviewmodel : homeviewmodel
    @EnvironmentObject var Loginviewmodel : loginviewmodel
    @State var password : String = ""
    @State var phone : String = ""
    @State var name : String = ""
    @State var email : String = ""
    @Binding var UserEmail : String
    @State var selectedDate : Date = Date()
    @State var showsheet : Bool = false
    @State var alertTitle : String = ""
    @State var showAlert : Bool = false
    let startingDate : Date = Calendar.current.date(from: DateComponents(year: 1923)) ?? Date()
    let endingDate : Date = Date()
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack (alignment: .topLeading){
            VStack {
                NavigationStack{
                    ScrollView {
                        VStack(spacing : 20){
                            TextField("Name",
                                      text: $name ,
                                      prompt: Text("Name").foregroundColor(.green)
                            )
                            .padding(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.green, lineWidth: 2)
                            }
                            .padding(.horizontal)
                            
                            
                            TextField("Email",
                                      text: $email ,
                                      prompt: Text("Email").foregroundColor(.green)
                            )
                            .padding(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.green, lineWidth: 2)
                            }
                            .padding(.horizontal)
                            Group{
                                Text("Enter your dob")
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
                                    }
                            }
                            Group{
                                TextField("Contact",
                                          text: $phone ,
                                          prompt: Text("Phone").foregroundColor(.green)
                                )
                                .padding(10)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.green, lineWidth: 2)
                                    
                                }
                                .padding(.horizontal)
                                
                                TextField("Paswword",
                                          text: $password ,
                                          prompt: Text("Password").foregroundColor(.green)
                                )
                                .padding(10)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.green, lineWidth: 2)
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(50)
                        .foregroundColor(.green)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        Button {
                            for user in Loginviewmodel.userDetails {
                                if password != "" && phone != "" && email != "" && name != "" && user.email == UserEmail {
                                    if isValidEmail(emailCheck: email){
                                        UserEmail = email
                                        Loginviewmodel.updateItem(person: user, name3: name, email3: email, steps3: 0, pass3: password, wallet3: 0, phone3: phone, participating3: user.partcipating)
                                        print("reached")
                                        showsheet.toggle()
                                    } else {
                                        showAlert.toggle()
                                        alertTitle = "Invalid Email"
                                    }
                                    
                                } else {
                                    showAlert.toggle()
                                    alertTitle = "Please fill in all Text Fields"
                                }
                            }
                        } label: {
                            Text("Submit")
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
                    .background(Color.gray.opacity(0.4))
                    .navigationBarTitle("Edit Account")
                    .navigationBarTitleDisplayMode(.automatic)
                }
                .fullScreenCover(isPresented: $showsheet, content: {
                    ActualView( UserEmail: $UserEmail, selectedTab: 4)
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
    
}

struct EditAccountView_Previews: PreviewProvider {
    static var previews: some View {
        EditAccountView(UserEmail: .constant("a"))
            .environmentObject(loginviewmodel())
    }
}
