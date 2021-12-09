//
//  MapSnapshotView.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 14.09.2021.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapSnapshotView: View {
    let location: CLLocationCoordinate2D
    let span: CLLocationDegrees
    let coordinates: [CLLocationCoordinate2D]?
    
   // @EnvironmentObject var preferences: PreferencesStorage
    
    @State private var snapshotImage: UIImage? = nil
    
    var body: some View {
        GeometryReader { geometry in
            Group {
                if let image = snapshotImage {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Image(uiImage: image)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                else {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .background(Color(UIColor.secondarySystemBackground))
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
            // Would be simply .onAppear, but it broke in iOS 14.5
           // .uiKitOnAppear {
            .onAppear {
                generateSnapshot(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
    
    func generateSnapshot(width: CGFloat, height: CGFloat) {
        
        
        let region = MKCoordinateRegion(
            center: self.location,
            span: MKCoordinateSpan(
                latitudeDelta: self.span,
                longitudeDelta: self.span
            )
        )
        
        // Map options
        let mapOptions = MKMapSnapshotter.Options()
        mapOptions.region = region
        mapOptions.size = CGSize(width: width, height: height)
        mapOptions.showsBuildings = true
        
        // Create the snapshotter and run it
        let snapshotter = MKMapSnapshotter(options: mapOptions)
        snapshotter.start { (snapshotOrNil, errorOrNil) in
            if let error = errorOrNil {
                print(error)
                return
            }
            if let snapshot = snapshotOrNil {
                let finalImage = UIGraphicsImageRenderer(size: snapshot.image.size).image { _ in
                    
                    snapshot.image.draw(at: .zero)

                    guard let coordinates = self.coordinates, coordinates.count > 1 else { return }
                    
                    // Convert the [CLLocationCoordinate2D] into a [CGPoint]
                    let points = coordinates.map { coordinate in
                        snapshot.point(for: coordinate)
                    }
                    
                    let path = UIBezierPath()
                    path.move(to: points[0])
                    
                    for point in points.dropFirst() {
                        path.addLine(to: point)
                    }

                    path.lineWidth = 8
                   // UserPreferences.convertColourChoiceToUIColor(colour: preferences.storedPreferences[0].colourChoiceConverted).setStroke()
                    path.stroke()
                }
                self.snapshotImage = finalImage
            }
        }
    }
}


func calculateSpan(latitudes: [CLLocationDegrees], longitudes: [CLLocationDegrees]) -> CLLocationDegrees {
    // Find the min and max latitude and longitude to find ideal span that fits entire route
    if (latitudes.count > 0 && longitudes.count > 0) {
        var maxLatitude: CLLocationDegrees = latitudes[0]
        var minLatitude: CLLocationDegrees = latitudes[0]
        var maxLongitude: CLLocationDegrees = longitudes[0]
        var minLongitude: CLLocationDegrees = longitudes[0]
        
        for latitude in latitudes {
            if (latitude < minLatitude) {
                minLatitude = latitude
            }
            if (latitude > maxLatitude) {
                maxLatitude = latitude
            }
        }
        
        for longitude in longitudes {
            if (longitude < minLongitude) {
                minLongitude = longitude
            }
            if (longitude > maxLongitude) {
                maxLongitude = longitude
            }
        }
        
        // Add 10% extra so that there is some space around the map
        let latitudeSpan = (maxLatitude - minLatitude) * 1.1
        let longitudeSpan = (maxLongitude - minLongitude) * 1.1
        return latitudeSpan > longitudeSpan ? latitudeSpan : longitudeSpan
    }
    else {
        return 0.1
    }
}

func setupCoordinates(latitudes: [CLLocationDegrees], longitudes: [CLLocationDegrees]) -> [CLLocationCoordinate2D] {
    var coordinates: [CLLocationCoordinate2D] = []
    
    var locationsCount = latitudes.count
    if (latitudes.count > longitudes.count) {
        locationsCount = longitudes.count
    }
    
    for index in 0..<locationsCount {
        coordinates.append(CLLocationCoordinate2DMake(latitudes[index], longitudes[index]))
    }
    
    return coordinates
}

func calculateCenter(latitudes: [CLLocationDegrees], longitudes: [CLLocationDegrees]) -> CLLocationCoordinate2D {
    // Find the min and max latitude and longitude to find ideal span that fits entire route
    if (latitudes.count > 0 && longitudes.count > 0) {
        var maxLatitude: CLLocationDegrees = latitudes[0]
        var minLatitude: CLLocationDegrees = latitudes[0]
        var maxLongitude: CLLocationDegrees = longitudes[0]
        var minLongitude: CLLocationDegrees = longitudes[0]
        
        for latitude in latitudes {
            if (latitude < minLatitude) {
                minLatitude = latitude
            }
            if (latitude > maxLatitude) {
                maxLatitude = latitude
            }
        }
        
        for longitude in longitudes {
            if (longitude < minLongitude) {
                minLongitude = longitude
            }
            if (longitude > maxLongitude) {
                maxLongitude = longitude
            }
        }
        
        let latitudeMidpoint = (maxLatitude + minLatitude)/2
        let longitudeMidpoint = (maxLongitude + minLongitude)/2
        return CLLocationCoordinate2D(latitude: latitudeMidpoint, longitude: longitudeMidpoint)
    }
    else {
        return CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
}
