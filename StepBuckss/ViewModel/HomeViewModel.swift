//
//  HomeViewModel.swift
//  StepBucks
//
//   Created by Rohan Prakash on 17/04/24.
//

import Foundation
import UIKit
import SwiftUI

class homeviewmodel : ObservableObject {
    @Published var quotesArray : [String] = []
    @Published var rewardsArray : [String] = []
    @Published var feedbackArray : [FeedbackModel] = [] {
        didSet{
            saveFeedbacks()
        }
    }
    var feedbackKey : String = "Feedback_data "
    
    init(){
        getImages()
        getRewards()
        getFeedback()
    }
    func getImages(){
        quotesArray.append(contentsOf: [String("quote1"),String("quote2"),String("quote3"),String("quote4"),String("quote5")])
    }
    func getRewards(){
        rewardsArray.append(contentsOf: [String("reward1"),String("reward2"),String("reward3"),String("reward4")])
    }
    func getFeedback(){
        guard
            let data = UserDefaults.standard.data(forKey: feedbackKey),
            let savedItems = try? JSONDecoder().decode([FeedbackModel].self, from: data)
        else { return }
        self.feedbackArray = savedItems
    }
    func addFeedback(feedback: String, stars: Int,name : String){
        let newItem = FeedbackModel(feedback: feedback, stars: stars, name: name)
        feedbackArray.append(newItem)
    }
    
    func saveFeedbacks () {
        if let encodedData = try? JSONEncoder () .encode (feedbackArray) {
            UserDefaults.standard.set(encodedData, forKey: feedbackKey)
        }
    }
}
