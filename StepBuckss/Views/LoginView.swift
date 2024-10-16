import SwiftUI

struct loginView: View {
    
    @EnvironmentObject var Loginviewmodel : loginviewmodel
    @State var feedbackArray : [FeedbackModel] = [FeedbackModel(feedback: "a", stars: 2, name: "a")]
    @State var email: String = ""
    @State var password: String = ""
    @State var showPassword: Bool = false
    @State var showSheet: Bool = false
    @State var logInAccess: Bool = false
    
    var isSignInButtonDisabled: Bool {
        [email, password].contains(where: \.isEmpty)
    }
    
    var body: some View {

            NavigationView {
                VStack(spacing: -10) {
                    Image("logo")
                        .resizable()
                        .frame(width: 500,height: 400)
                        .aspectRatio(contentMode: .fill)
                        .padding(.trailing,58)
                        .padding(.top,-100)
                    VStack(spacing: 15) {
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
                        HStack {
                            Group {
                                if showPassword {
                                    TextField("Password",
                                                text: $password,
                                                prompt: Text("Password").foregroundColor(.green))
                                } else {
                                    SecureField("Password",text: $password,
                                                prompt: Text("Password").foregroundColor(.green))
                                }
                            }
                            .padding(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.green, lineWidth: 2)
                            }

                            Button {
                                showPassword.toggle()
                            } label: {
                                Image(systemName: showPassword ? "eye.slash" : "eye")
                                    .foregroundColor(.primary)
                            }
                        }.padding(.horizontal)
                        
                        
                        Button(action: {
                            for user in Loginviewmodel.userDetails{
                                if user.email == email && user.pass == password{
                                    print("ok")
                                    logInAccess.toggle()
                                }
                            }
                        }, label: {
                            Text("Log In").font(.title2)
                                .bold()
                                .foregroundColor(.white)
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .background(isSignInButtonDisabled ? Color.gray : Color.green)
                                .cornerRadius(20)
                                .padding()
                        })
                        .fullScreenCover(isPresented: $logInAccess, content: {
                            ActualView(UserEmail: $email)
//                            ContentView()
                        })
                        .disabled(isSignInButtonDisabled)
                    }
                    Button {
                        showSheet.toggle()
                    } label: {
                        Text("Don't have an account ? Sign Up")
                    }
                    .sheet(isPresented: $showSheet, content: { SignUpView() })
                }
                .navigationBarBackButtonHidden(true)
            }
    }
}

struct loginView_Previews: PreviewProvider {
    static var previews: some View {
        loginView()
    }
}
