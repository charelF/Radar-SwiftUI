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
    let coordinate: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
//        let coordinate = CLLocationCoordinate2D(
//            latitude: 34.011286, longitude: -116.166868)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
    
}

struct ActivityMapView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityMapView(coordinate: CLLocationCoordinate2D(
            latitude: 34.011286, longitude: -116.166868))
    }
}
