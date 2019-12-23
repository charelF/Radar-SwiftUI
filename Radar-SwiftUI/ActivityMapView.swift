//
//  ActivityMapView.swift
//  Radar-SwiftUI
//
//  Created by Charel FELTEN on 09/11/2019.
//  Copyright © 2019 Charel FELTEN. All rights reserved.
//

import SwiftUI
import MapKit

struct ActivityMapView: UIViewRepresentable {
    let coordinate: CLLocationCoordinate2D?
    let coordinates: [CLLocationCoordinate2D]?
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.coordinates = nil
    }
    
    init(coordinates: [CLLocationCoordinate2D]) {
        self.coordinates = coordinates
        self.coordinate = nil
    }
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let center: CLLocationCoordinate2D
        let spanDelta: Double
        
        // not elegant, but we check if we have one or multiple coordinates
        // and then proceed acoordingly
        if let coord = coordinate {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coord
            view.addAnnotation(annotation)
            spanDelta = 0.1
            center = coord
        } else {
            // either coordinates is not nil and we can proceed, or it is, then an error can be rightfully thrown as both are nil
            view.addAnnotations(coordinates!.map( { (coordinate) -> MKAnnotation in
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                return annotation
            }))
            spanDelta = 1.0
            center = CLLocationCoordinate2D(latitude: 49.800, longitude: 6.100)
        }
        
        let span = MKCoordinateSpan(latitudeDelta: spanDelta, longitudeDelta: spanDelta)
        let region = MKCoordinateRegion(center: center, span: span)
        view.setRegion(region, animated: true)
    }
}

struct ActivityMapView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityMapView(coordinate: CLLocationCoordinate2D(
            latitude: 34.011286, longitude: -116.166868))
    }
}
