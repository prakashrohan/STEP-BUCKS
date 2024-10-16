//
//  UserViewModel.swift
//  StepBucks
//
//   Created by Rohan Prakash on 17/04/24.
//

import Foundation

class loginviewmodel : ObservableObject{
    let userKey : String = "user_list"
    
    @Published var userDetails : [UserModel] = [UserModel(name: "Akshat Bhansali", email: "Akshat@gmail.com", steps: 0, pass: "123456", wallet: 0, phone: "8355847600"),UserModel(name: "Ashish Jain", email: "Ashish@gmail.com", steps: 0, pass: "123456", wallet: 0, phone: "9987586094"),UserModel(name: "Usain Bolt",  email: "Bolt@gmail.com", steps: 0, pass: "123456", wallet: 0, phone: "987654321"),UserModel(name: "Cristiano Ronaldo", email: "Cristiano@gmail.com", steps: 0, pass: "123456", wallet: 0, phone: "9876543210"),UserModel(name: "Milkha Singh", email: "Milkha@gmail.com", steps: 0, pass: "123456", wallet: 0, phone: "9876543210"),UserModel(name: "Virat Kohli", email: "Virat@gmail.com", steps: 0, pass: "123456", wallet: 0, phone: "9876543210"),UserModel(name: "Sharma Ji", email: "Sharma@gmail.com", steps: 0, pass: "123456", wallet: 0, phone: "9876543210"),UserModel(name: "Aryan Rathore", email: "Aryan@gmail.com", steps: 0, pass: "123456", wallet: 0, phone: "9876543210"),UserModel(name: "Ashok Roy", email: "Ashok@gmail.com", steps: 0, pass: "123456", wallet: 0, phone: "9876543210"),UserModel(name: "Ayush Sharma", email: "Ayush@gmail.com", steps: 0, pass: "123456", wallet: 0, phone: "9876543210"),UserModel(name: "Prashik Pagare", email: "Prashik@gmail.com", steps: 0, pass: "123456", wallet: 0, phone: "9876543210"),UserModel(name: "Kuldeep Jhala", email: "Kuldeep@gmail.com", steps: 0, pass: "123456", wallet: 0, phone: "9876543210"),UserModel(name: "Dheeraj Parikh", email: "Dheeraj@gmail.com", steps: 0, pass: "123456", wallet: 0, phone: "9876543210"),UserModel(name: "Akshit Nandan", email: "Akshit@gmail.com", steps: 0, pass: "123456", wallet: 0, phone: "9876543210"),UserModel(name: "Mudit", email: "Mudit@gmail.com", steps: 0, pass: "123456", wallet: 0, phone: "9876543210"),UserModel(name: "Dhruv Chauhan", email: "Dhruv@gmail.com", steps: 0, pass: "123456", wallet: 0, phone: "9876543210"),UserModel(name: "Aarav Saina", email: "Aarav@gmail.com", steps: 0, pass: "123456", wallet: 0, phone: "9876543210"),
        UserModel(name: "MS Dhoni", email: "Dhoni@gmail.com", steps: 0, pass: "123456", wallet: 0, phone: "9876543210")] {
        didSet{
            saveFeedback()
        }
    }
        init() {
            getFeedback()
        }

    func addUser(name: String,  email: String, steps: Int , pass: String, wallet : Double , phone : String ){
        let newItem = UserModel(name: name,  email: email, steps: steps, pass: pass, wallet: wallet, phone: phone)
        userDetails.append(newItem)
    }
        func saveFeedback () {
            if let encodedData = try? JSONEncoder () .encode (userDetails) {
                UserDefaults.standard.set(encodedData, forKey: userKey)
            }
        }
        func getFeedback(){
            guard
                let data = UserDefaults.standard.data(forKey: userKey),
                let savedItems = try? JSONDecoder().decode([UserModel].self, from: data)
            else { return }
            //above data is not sure
            self.userDetails = savedItems
        }
    func updateItem( person : UserModel , name3 : String, email3 : String, steps3 : Int, pass3 : String, wallet3 : Double, phone3 : String , participating3 : Bool){
        if let index = userDetails.firstIndex(where: { $0.id == person.id }){
            userDetails[index] = person.updateCompletion(name2: name3, email2: email3, steps2: steps3, pass2: pass3, wallet2: wallet3, phone2: phone3, participating2 : participating3)
        }
        userDetails = userDetails.sorted(by: {$0.steps > $1.steps})
    }
}
