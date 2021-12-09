//
//  MapTrackView.swift
//  PetManager
//
//  Created by Анастасия Беспалова on 15.09.2021.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapTrackView: View {
    @EnvironmentObject var activityEntryViewModel: ActivityEntryViewModel
  //  @ObservedObject var petWalkTrackViewModel: PetWalkTrackViewModel
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
            MapTrack(location: calculateCenter(latitudes: activityEntryViewModel.entryInfo.withBikeRide!.cyclingLatitudes, longitudes: activityEntryViewModel.entryInfo.withBikeRide!.cyclingLongitudes),
                     span: calculateSpan(latitudes: activityEntryViewModel.entryInfo.withBikeRide!.cyclingLatitudes, longitudes: activityEntryViewModel.entryInfo.withBikeRide!.cyclingLongitudes),
                     coordinates: setupCoordinates(latitudes: activityEntryViewModel.entryInfo.withBikeRide!.cyclingLatitudes, longitudes: activityEntryViewModel.entryInfo.withBikeRide!.cyclingLongitudes))
                .ignoresSafeArea()
            }
            
            HStack(alignment: .bottom) {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .frame(width: 100, height: 50)
                        .opacity(0.6)
                    Text(MetricsFormatting.formatDistance(distance: activityEntryViewModel.entryInfo.withBikeRide!.cyclingDistance, usingMetric: true))
                }
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .frame(width: 100, height: 50)
                        .opacity(0.6)
                    Text(MetricsFormatting.formatTime(time: activityEntryViewModel.entryInfo.withBikeRide!.cyclingTime))
                }
                Spacer()
            }
           
        }
       
    }
    
 
}

struct MapTrack: UIViewRepresentable {
    
    let location: CLLocationCoordinate2D
    let span: CLLocationDegrees
    let coordinates: [CLLocationCoordinate2D]?

    
    func makeCoordinator() -> MapTrack.Coordinator {
        Coordinator(self, colour: .purple)
    }
    
    typealias UIViewType = MKMapView
    
    final class Coordinator: NSObject, MKMapViewDelegate {
        var control: MapTrack
        var colour: UIColor
        
        init(_ control: MapTrack, colour: UIColor) {
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
        
        
        
        let region = MKCoordinateRegion(
            center: self.location,
            span: MKCoordinateSpan(
                latitudeDelta: self.span,
                longitudeDelta: self.span
            )
        )
        
        view.setRegion(region, animated: true)
        
       // let location2: CLLocationCoordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(location.latitude)!, CLLocationDegrees(location.longitude)!)
       // let span = MKCoordinateSpan(latitudeDelta: 0.009, longitudeDelta: 0.009)
         //  let region = MKCoordinateRegion(center: location2, span: span)
        let locationsCount = coordinates?.count ?? 0
        switch locationsCount {
        case _ where locationsCount < 1:
            break
       // case _ where locationsCount == 1:
            
        default:
            let route = MKPolyline(coordinates: coordinates!, count: locationsCount)
            view.addOverlay(route)
            
        }
        view.delegate = context.coordinator
    }
    
    
}
