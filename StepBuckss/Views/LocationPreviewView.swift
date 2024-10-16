//
//  LocationPreviewView.swift
//  MapApp
//
//   Created by Rohan Prakash on 17/04/24.
//

import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject var vm :LocationsViewModel
    let location : Location
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing:16){
                imageSection
                titleSection
            }
            VStack(spacing:8){
                learnMoreButton
                nextButton
            }
        }
        .padding(20)
        .background(RoundedRectangle(cornerRadius: 20)
            .fill(.ultraThinMaterial)
            .offset(y:65))
        .cornerRadius(20)
    }
}

struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        LocationPreviewView(location: LocationsDataService.locations.first!)
            .environmentObject(LocationsViewModel())
    }
}


extension LocationPreviewView{
    var imageSection : some View {
        ZStack{
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100,height: 100)
                    .cornerRadius(15)
            }
        }
    .padding()
    .background(Color.white)
    .frame(width: 110,height: 110)
    .cornerRadius(15)
    }
    var titleSection : some View{
        VStack(alignment: .leading, spacing: 4){
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
    var learnMoreButton : some View  {
        Button {
            vm.sheetLocation = location
        } label: {
            Text("Learn More")
                .font(.headline)
                .frame(width: 125,height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    var nextButton : some View  {
        Button {
            withAnimation(.spring()){
                vm.nextButtonPressed()
            }
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125,height: 35)
        }
        .buttonStyle(.bordered)
    }
}
