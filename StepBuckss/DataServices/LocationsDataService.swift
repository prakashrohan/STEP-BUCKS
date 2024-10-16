//
//  LocationsDataService.swift
//  MapTest
//
//  Created by Nick Sarno on 11/26/21.
//

import Foundation
import MapKit

class LocationsDataService {
    
    static let locations: [Location] = [
        Location(
            name: "Wifi Garden,IIITL",
            cityName: "Lucknow",
            coordinates: CLLocationCoordinate2D(latitude: 26.800419, longitude: 81.024320),
            description: "The wifi garden is the most popular place in entire of IIITL. It is a sweet spot for young college couples and their romance. It is also a place where energetic college students show off their cricket and football skills. Most of the time you will find people walking in the garden.",
            imageNames: [
                "collg-1",
                "collg-2"
            ],
            link: "https://en.wikipedia.org/wiki/Indian_Institute_of_Information_Technology%2C_Lucknow"),
        Location(
            name: "Janeshwar Mishra Park",
            cityName: "Lucknow",
            coordinates: CLLocationCoordinate2D(latitude: 26.845330, longitude: 80.954730),
            description: "Janeshwar Mishra Park is a large public park in Lucknow, India, covering 376 acres. It has a lake, musical fountain, rose garden, and outdoor fitness equipment. The park is named after a socialist leader and is a popular destination for locals and tourists.",
            imageNames: [
                "janeshwar-mishra-1",
                "janeshwar-mishra-2",
                "janeshwar-mishra-3",
            ],
            link: "https://en.wikipedia.org/wiki/Janeshwar_Mishra_Park"),
        Location(
            name: "Dr. Ram Manohar Lohia Park",
            cityName: "Lucknow",
            coordinates: CLLocationCoordinate2D(latitude: 26.840720, longitude: 80.951020),
            description: "Lohia Park is a public park in Lucknow, Uttar Pradesh, India. Spread over an area of 76 acres, the park has a jogging track, skating rink, children's play area, and various gardens with a variety of plants and flowers. The park is named after the socialist leader, Ram Manohar Lohia and is a popular destination for locals and visitors.",
            imageNames: [
                "lohia-1",
                "lohia-2",
                "lohia-3",
            ],
            link: "https://en.wikipedia.org/wiki/Dr._Ram_Manohar_Lohia_Park,_Gomti_Nagar"),
        Location(
            name: "Ambedkar Memorial Park",
            cityName: "Lucknow",
            coordinates: CLLocationCoordinate2D(latitude: 26.810225, longitude: 80.919525),
            description: "Ambedkar Memorial Park is a public park and memorial in Lucknow, India, dedicated to B. R. Ambedkar, the Indian jurist, economist, and social reformer. The park covers an area of 107 acres and has various attractions, including a museum, a bronze statue of Ambedkar, a fountain, and a large open-air auditorium. It is a popular destination for locals and visitors alike.",
            imageNames: [
                "ambedkar-1",
                "ambedkar-2",
                "ambedkar-3",
            ],
            link: "https://en.wikipedia.org/wiki/Ambedkar_Memorial_Park")
    ]
    
}
