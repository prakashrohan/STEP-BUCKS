//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by Rohan Prakash on 17/04/24.
//

import Foundation
import MapKit

class LocationsViewModel : ObservableObject {
    @Published var locations : [Location]
    @Published var mapLocation : Location{
        didSet{
            updateMapRegion(location: mapLocation)
        }
    }
    @Published var mapRegion : MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    @Published var showLocationsList : Bool = false
    @Published var sheetLocation : Location? = nil
    init(){
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    
     func updateMapRegion(location : Location){
        mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
    }
     func toggleLocationslist(){
            showLocationsList.toggle()
    }
    func showNextLocation(location : Location){
        mapLocation = location
        showLocationsList = false
    }
    func nextButtonPressed(){
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            print("no location")
            return
        }
        
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        
        let nextLocation = locations [nextIndex]
        showNextLocation (location: nextLocation)
    }
}
