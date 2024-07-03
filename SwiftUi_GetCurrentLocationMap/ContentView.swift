//
//  ContentView.swift
//  SwiftUi_GetCurrentLocationMap
//
//  Created by Rodrigo Prado on 02/07/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    // Example list of locations with latitude and longitude
    let locations = [
            Location(id: 1, coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), name: "San Francisco"),
            Location(id: 2, coordinate: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437), name: "Los Angeles"),
            Location(id: 3, coordinate: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060), name: "New York"),
            Location(id: 4, coordinate: CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278), name: "London"),
            Location(id: 5, coordinate: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522), name: "Paris")
        ]
    
    var body: some View {
        Map(position: $position)
        {
            UserAnnotation()
            
            // Adding markers for each location in the list
            ForEach(locations, id: \.id) { location in
                Marker(location.name, coordinate: location.coordinate)
            }
        }
        .mapControls{
            MapUserLocationButton()
            MapPitchToggle()
        }
        .onAppear{
            CLLocationManager().requestWhenInUseAuthorization()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Location: Identifiable {
    let id: Int
    let coordinate: CLLocationCoordinate2D
    let name: String
}
