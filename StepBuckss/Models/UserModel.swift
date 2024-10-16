//
//  PartcipantModel.swift
//  StepBucks
//
//   Created by Rohan Prakash on 17/04/24.
//

import Foundation

struct UserModel : Identifiable , Codable,Equatable{
    var id : String
    var name : String
    var email : String
    var steps : Int
    var pass : String
    var wallet : Double
    var phone : String
    var partcipating : Bool
    
    init(id:String = UUID().uuidString, name: String, email: String, steps: Int , pass: String, wallet : Double  , phone : String, participating : Bool = false ) {
        self.id = id
        self.name = name
        self.email = email
        self.steps = steps
        self.pass = pass
        self.wallet = wallet
        self.phone = phone
        self.partcipating = participating
    }
    func updateCompletion(name2: String, email2: String, steps2: Int, pass2: String, wallet2: Double, phone2: String, participating2 : Bool) -> UserModel {
        return UserModel(name: name2, email: email2, steps: steps2, pass: pass2, wallet: wallet2, phone: phone2, participating: participating2)
    }
}
