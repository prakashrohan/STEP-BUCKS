//
//  ContestVIewModel.swift
//  StepBuckss
//
//   Created by Rohan Prakash on 17/04/24.
//

import Foundation

class contestviewmodel : ObservableObject{
    let contestKey : String = "contest_key"
    
    let startingTime : Date = Calendar.current.date(from: DateComponents(hour: 9)) ?? Date()
    let endingTime : Date = Calendar.current.date(from: DateComponents(day:110,hour: 10)) ?? Date()
    
    @Published var contestArray : [ContestModel] = [
        ContestModel(title: "Walkathon-4", startTime: Calendar.current.date(from: DateComponents(year: 2023,day: 114,hour: 1,minute: 0)) ?? Date(), endTime: Calendar.current.date(from: DateComponents(year: 2023,day: 114,hour: 1,minute: 5)) ?? Date(), entryFee: 50, maxParticipants: 100, currentParticipants: 0, MaxprizePool: 4750, multiplierStart: Calendar.current.date(from: DateComponents(year: 2023,day: 114,hour: 1,minute: 3)) ?? Date(), multiplierEnd: Calendar.current.date(from: DateComponents(year: 2023,day: 114,hour: 1,minute: 5)) ?? Date(), entryTime: Calendar.current.date(from: DateComponents(year: 2023,day: 113,hour: 1,minute: 50)) ?? Date(), exitTime: Calendar.current.date(from: DateComponents(year: 2023,day: 114,hour: 2,minute: 30)) ?? Date(), CurrentpricePool: 0, rewarded: false)]{
        didSet{
            saveContest()
        }
    }
        init() {
            getContest()
        }
    func saveContest () {
        if let encodedData = try? JSONEncoder () .encode (contestArray) {
            UserDefaults.standard.set(encodedData, forKey: contestKey)
        }
    }
    func getContest(){
        guard
            let data = UserDefaults.standard.data(forKey: contestKey),
            let savedItems = try? JSONDecoder().decode([ContestModel].self, from: data)
        else { return }
        //above data is not sure
        self.contestArray = savedItems
    }
    func updateItem( contest : ContestModel , title3: String, startTime3: Date,endTime3: Date, entryFee3 : Double,maxParticipants3:Int,currentParticipants3:Int , MaxprizePool3:Double,multiplierStart3 : Date , multiplierEnd3 : Date , entryTime3 : Date,exitTime3 : Date,CurrentpricePool3 : Double,rewarded3 : Bool){
        if let index = contestArray.firstIndex(where: { $0.id == contest.id }){
            contestArray[index] = contest.updateCompletion(title: title3, startTime: startTime3,endTime: endTime3, entryFee: entryFee3,maxParticipants:maxParticipants3,currentParticipants:currentParticipants3 , MaxprizePool:MaxprizePool3,multiplierStart: multiplierStart3 , multiplierEnd: multiplierEnd3 , entryTime: entryTime3,exitTime: exitTime3, CurrentpricePool: CurrentpricePool3, rewarded: rewarded3)
        }
    }
}



