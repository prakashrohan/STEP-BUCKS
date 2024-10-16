//
//  LocationsView.swift
//  MapApp
//
//   Created by Rohan Prakash on 17/04/24.
//

import SwiftUI
import MapKit



struct LocationsView: View {
    
    @EnvironmentObject var vm : LocationsViewModel
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $vm.mapRegion, showsUserLocation: true, annotationItems: vm.locations, annotationContent: { location in
                MapAnnotation(coordinate: location.coordinates) {
                    LocationMapAnnotation()
                        .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                        .shadow(radius: 10)
                        .onTapGesture {
                            withAnimation(.spring()){
                                vm.showNextLocation(location: location)
                            }
                        }
                }
            })
                .ignoresSafeArea()
            VStack(spacing: 0){
                
                header
                .padding()
                Spacer()
                ForEach(vm.locations){location in
                    if vm.mapLocation == location {
                        LocationPreviewView(location: location)
                            .shadow(color: Color.black.opacity(0.3), radius: 20)
                            .padding()
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    }
                }
            }
        }
        .sheet(item: $vm.sheetLocation, onDismiss: nil) { location in
            LocationDetailView(location: location)
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationsView{
    private var header : some View{
        VStack {
            Button {
                withAnimation(.easeInOut) {
                    vm.toggleLocationslist()
                }
            } label: {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationsList ? 180 : 0))
                    }
            }

            if vm.showLocationsList{
                LocationsListView()
            }
        }
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.3), radius: 20,y: 20)
    }
}
