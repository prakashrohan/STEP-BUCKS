//
//  ContestModel.swift
//  StepBuckss
//
//   Created by Rohan Prakash on 17/04/24.
//

import Foundation

struct ContestModel : Identifiable , Codable{
    var id : String
    var title : String
    var startTime : Date
    var endTime : Date
    var entryFee : Double
    var maxParticipants : Int
    var currentParticipants : Int
    var MaxprizePool : Double
    var CurrentpricePool : Double
    var multiplierStart : Date
    var multiplierEnd : Date
    var entryTime : Date
    var exitTime : Date
    var rewarded : Bool
    
    
    init(id: String = UUID().uuidString, title: String, startTime: Date,endTime : Date, entryFee : Double,maxParticipants:Int,currentParticipants:Int , MaxprizePool:Double,multiplierStart : Date , multiplierEnd : Date , entryTime : Date,exitTime : Date, CurrentpricePool : Double,rewarded : Bool) {
        self.id = id
        self.title = title
        self.startTime = startTime
        self.endTime = endTime
        self.entryFee = entryFee
        self.currentParticipants = currentParticipants
        self.maxParticipants = maxParticipants
        self.MaxprizePool = MaxprizePool
        self.multiplierStart = multiplierStart
        self.multiplierEnd = multiplierEnd
        self.entryTime = entryTime
        self.exitTime = exitTime
        self.CurrentpricePool = CurrentpricePool
        self.rewarded = rewarded
    }
    func updateCompletion( title: String, startTime: Date,endTime : Date, entryFee : Double,maxParticipants:Int,currentParticipants:Int , MaxprizePool:Double,multiplierStart : Date , multiplierEnd : Date , entryTime : Date,exitTime : Date ,CurrentpricePool : Double,rewarded:Bool) -> ContestModel {
        return ContestModel(title: title, startTime: startTime, endTime: endTime, entryFee: entryFee, maxParticipants: maxParticipants, currentParticipants: currentParticipants, MaxprizePool: MaxprizePool, multiplierStart: multiplierStart, multiplierEnd: multiplierEnd, entryTime: entryTime, exitTime: exitTime,CurrentpricePool: CurrentpricePool,rewarded: rewarded)
    }
}
