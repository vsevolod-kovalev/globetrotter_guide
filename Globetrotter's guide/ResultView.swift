//
//  ResultView.swift
//  Globetrotter's guide
//
//  Created by Samuel Hickman on 2/17/24.
//

import SwiftUI

func getLocations(placesTV: [String] ) -> [Location] {
    var result: [Location] = []
    
    for place in placesTV {
        let location = Location(
            name: place,
            imageName: "\(place.lowercased())_image", // Create imageName from place name
            description: "Description for {\(place)}."
        )
        result.append(location)
    }
    return result
}

struct ResultView: View {
    @Binding var query: String
    var cityDescriptionArg: String
    var placesArg: [String]
    //var locations: [Location]
    
    var sampleLocations: [Location] = [
        Location(name: "Location 1", imageName: "location1", description: "Description for Location 1."),
        Location(name: "Location 2", imageName: "location2", description: "Description for Location 2."),
        Location(name: "Location 3", imageName: "location3", description: "Description for Location 3."),
        // Add more sample locations as needed
    ]
    
    @State private var selectedLocationIndex: Int?

    var body: some View {
        
        let locations = getLocations(placesTV: placesArg)
        
        NavigationView {
            ScrollView(.vertical) {
                VStack {
                    Text("Result Page")
                        .font(.largeTitle)
                        .padding()
                    
                    Text("Query: \(query)")
                        .foregroundColor(.gray)
                        .padding()

                    ForEach(locations.indices, id: \.self) { index in
                        NavigationLink(destination: LocationDetailView(location: locations[index]), tag: index, selection: $selectedLocationIndex) {
                            LocationTabView(location: locations[index])
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .navigationBarTitle("Result")
                .onAppear {
                    // Set selectedLocationIndex to nil to disable automatic opening
                    selectedLocationIndex = nil
                }
            }
        }
    }
}

struct LocationTabView: View {
    var location: Location

    var body: some View {
        VStack {
            Image(location.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 150)
                .cornerRadius(10)
                .padding()

            Text(location.name)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 5)

            Text(location.description)
                .foregroundColor(.gray)
                .padding()
        }
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding()
    }
}

struct LocationDetailView: View {
    var location: Location

    var body: some View {
        VStack {
            Image(location.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .padding()

            Text(location.name)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 5)

            Text(location.description)
                .foregroundColor(.gray)
                .padding()
        }
        .navigationBarTitle(location.name)
    }
}
