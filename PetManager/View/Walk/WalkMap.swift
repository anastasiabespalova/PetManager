//
//  WalkMap.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 25.08.2021.
//

class CyclingStatus: ObservableObject {
    @Published var isCycling = false
    
    func startedCycling() {
        isCycling = true
    }
    
    func stoppedCycling() {
        isCycling = false
    }
}
 
var startedCycling = false

import SwiftUI
import MapKit
import CoreLocation

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView
    
    let persistenceController = CoreDataManager.shared

    @EnvironmentObject var petWalkViewModel: PetWalkViewModel
    @EnvironmentObject var cyclingStatus: CyclingStatus
   // @State var cyclingStatus: CyclingStatus
    @StateObject var locationManager: LocationViewModel
    //@State var walkStarted: Bool
    @Binding var centerMapOnLocation: Bool
   // @Binding var cyclingStartTime: Date
   // @Binding var timeCycling: TimeInterval
    
    var userLatitude: String {
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }
        
    var userLongitude: String {
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }
    
    func makeCoordinator() -> MapView.Coordinator {
        Coordinator(self, colour: .purple)
    }

    final class Coordinator: NSObject, MKMapViewDelegate {
        var control: MapView
        var colour: UIColor

        init(_ control: MapView, colour: UIColor) {
            self.control = control
            self.colour = colour
        }

        //Managing the Display of Overlays
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let polylineRenderer = MKPolylineRenderer(overlay: polyline)
                polylineRenderer.strokeColor = colour
                polylineRenderer.lineWidth = 8
                return polylineRenderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
    }

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        view.showsUserLocation = true
        
        let authStatus = locationManager.statusString
        
        if (authStatus == "authorizedAlways" || authStatus == "authorizedWhenInUse") {
            let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(userLatitude)!, CLLocationDegrees(userLongitude)!)
            let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
            let region = MKCoordinateRegion(center: location, span: span)
            if (centerMapOnLocation) {
                view.setRegion(region, animated: true)
            }
            
            // Need to maintain the cyclists route if they are currently cycling
            if cyclingStatus.isCycling {
                if (!startedCycling) {
                    startedCycling = true
                    locationManager.startedCycling()
                }
                let locationsCount = locationManager.cyclingLocations.count
                switch locationsCount {
                case _ where locationsCount < 2:
                    break
                default:
                    var locationsToRoute : [CLLocationCoordinate2D] = []
                    for location in locationManager.cyclingLocations {
                        if (location != nil) {
                            locationsToRoute.append(location!.coordinate)
                        }
                    }
                    if (locationsToRoute.count > 1 && locationsToRoute.count <= locationManager.cyclingLocations.count) {
                        let route = MKPolyline(coordinates: locationsToRoute, count: locationsCount)
                        view.addOverlay(route)
                        
                    }
                }
            }
            else {
               // print("i'm there")
                // Means we need to store the current route and clear the map
                if (startedCycling) {
                //if (walkStarted) {
                    //print("i'm here")
                    startedCycling = false
                    let overlays = view.overlays
                    view.removeOverlays(overlays)
                   // persistenceController.storeBikeRide(locations: locationManager.cyclingLocations,
                                                      //  speeds: locationManager.cyclingSpeeds,
                                                      //  distance: locationManager.cyclingTotalDistance,
                                                       // elevations: locationManager.cyclingAltitudes,
                                                      //  startTime: cyclingStartTime,
                                                       // time: timeCycling, id: locationManager.id)
                    
                  //  locationManager.clearLocationArray()
                  //  locationManager.stopTrackingBackgroundLocation()
                }
            }
            view.delegate = context.coordinator
        }
    }
}

struct WalkMap: View {
    
    let locationManager = CLLocationManager()
    
    var coordinate: CLLocationCoordinate2D
        
    @State private var region = MKCoordinateRegion()
    
    var body: some View {
        Map(coordinateRegion: $region).onAppear() {
            setRegion(coordinate)
        }
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.040, longitudeDelta: 0.040))
    }
}


