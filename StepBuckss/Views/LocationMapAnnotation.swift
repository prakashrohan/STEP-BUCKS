//
//  LocationMapAnnotation.swift
//  MapApp
//
//   Created by Rohan Prakash on 17/04/24.
//

import SwiftUI

struct LocationMapAnnotation: View {
    var body: some View {
        VStack(spacing:0){
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame (width: 30, height: 30)
                .font (.headline)
                .foregroundColor (.white)
                .padding (6)
                .background (Color.red)
                .cornerRadius (36)
            
            Image (systemName: "triangle.fill")
            .resizable ()
            .scaledToFit ()
            .foregroundColor (Color.red)
            .frame (width: 10, height: 10)
            .rotationEffect(Angle (degrees: 180))
            .offset (y: -3)
            .padding (.bottom, 40)
        }
    }
}

struct LocationMapAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapAnnotation()
    }
}
