//
//  HomeView.swift
//  StepBucks
//
//   Created by Rohan Prakash on 17/04/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var Homeviewmodel : homeviewmodel
    @State var rating : Int = 0
    @State var feedbackText : String = ""
    @State var tempIndex : Int = 0
    @EnvironmentObject var Loginviewmodel : loginviewmodel
    @Binding var UserEmail : String
    
    var body: some View {
        ScrollView {
            VStack(spacing : 40) {
                VStack(spacing:10){
                    Text("Quotes")
                        .font(.title)
                        .fontWeight(.bold)
                ScrollView(.horizontal , showsIndicators: false) {
                    HStack{
                        ForEach(Homeviewmodel.quotesArray,id: \.self) {quotes in
                            Image(quotes)
                                .resizable()
                                .frame(width: 300 , height: 150)
                                .cornerRadius(20)
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
                }
                VStack(spacing:10){
                    Text("Upcoming Mega League Prizes")
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    ScrollView(.horizontal , showsIndicators: false) {
                        HStack{
                            ForEach(Homeviewmodel.rewardsArray,id: \.self) {rewards in
                                Image(rewards)
                                    .resizable()
                                    .frame(width: 300 , height: 150)
                                    .cornerRadius(20)
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                    }
                }
                
            
                VStack(spacing:10){
                    Text("Feedback from others ")
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    VStack(spacing : 30){
                        ForEach(Homeviewmodel.feedbackArray) { star in
                            VStack(spacing: 0){
                                HStack{
                                    Image(systemName: "person.fill")
                                    Text(star.name + " - \(star.stars) Stars")
                                }
                                .frame(width: 300)
                                .background(Color.green.opacity(0.3))
                                
                                Text(star.feedback)
                                    .frame(width: 300,height: 60)
                                    .background(Color.green.opacity(0.6))
                            }
                            .cornerRadius(20)
                        }
                    }
                }
                
                VStack(spacing:8){
                    Text("Your feedback matters to us!")
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    ZStack{
                        starsView
                            .overlay(overlayView.mask(starsView))
                    }
                TextField("Enter your feedback", text: $feedbackText)
                        .font(.title3)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .padding()
                        .padding(.bottom,110)
                        .frame(width: 350,height: 150)
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(20)
                }
                    
                    Button {
                        for user in Loginviewmodel.userDetails{
                            if user.email == UserEmail {
                                Homeviewmodel.addFeedback(feedback: feedbackText, stars: tempIndex, name: user.name)
                                rating = 0
                                feedbackText = ""
                            }
                        }
                    } label: {
                        Text("Submit")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .frame(width: 250)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.black)
                            .cornerRadius(50)
                            .shadow(radius: 10)
                            .frame(width: 180,height: 90)
                    }
            }
        }
    }
    private var overlayView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor (.yellow)
                    .frame (width: CGFloat (rating) / 5 * geometry .size.width)
            }
        }
        .allowsHitTesting(false)
    }
    
    private var starsView: some View {
        HStack{
            ForEach(1..<6) { index in
                Image (systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color.gray)
                    .onTapGesture {
                        withAnimation (.easeInOut) {
                            rating = index
                            tempIndex = index
                        }
                    }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView( UserEmail: .constant("a"))
            .environmentObject(homeviewmodel())
    }
}
