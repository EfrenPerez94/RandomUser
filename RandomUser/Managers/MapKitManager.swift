//
//  MapKitManager.swift
//  RandomUser
//
//  Created by Efrén Pérez Bernabe on 24/03/21.
//

import MapKit

class MapKitManager {
    
    /// Open a location in the App Maps
    /// - Parameters:
    ///   - latitude: Latitude value as Double
    ///   - longitude: Longitude value as Double
    static func openLocationInMaps(latitude: Double, longitude: Double) {
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
        mapItem.name = "Target location"
        mapItem.openInMaps(launchOptions: nil)
    }
    
}
