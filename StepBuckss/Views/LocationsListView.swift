//
//  LocationsListView.swift
//  MapApp
//
//   Created by Rohan Prakash on 17/04/24.
//

import SwiftUI

struct LocationsListView: View {
    
    @EnvironmentObject var vm : LocationsViewModel
    
    var body: some View {
        List{
            ForEach(vm.locations) { location in
                Button {
                    withAnimation(.spring()) {
                        vm.showNextLocation(location: location)
                    }
                } label: {
                    listRowView(location : location)
                }
                .padding(.vertical,4)
            }
        }
        .listStyle(.plain )
    }
}

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationsListView{
    private func listRowView(location : Location) -> some View {
        HStack{
            if let imageName = location.imageNames.first{
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45,height: 55)
                    .cornerRadius(15)
            }
            VStack(alignment:.leading){
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
        }
    }
}
