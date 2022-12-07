//
//  Location+Ext.swift
//  FriendsField
//
//  Created by Scalelot Technologies on 25/05/22.
//

import Foundation
import CoreLocation
import Contacts

extension CLPlacemark {
    /// street name, eg. Infinite Loop
    var streetName: String? { thoroughfare }
    /// // eg. 1
    var streetNumber: String? { subThoroughfare }
    /// city, eg. Cupertino
    var city: String? { locality }
    /// neighborhood, common name, eg. Mission District
    var neighborhood: String? { subLocality }
    /// state, eg. CA
    var state: String? { administrativeArea }
    /// county, eg. Santa Clara
    var county: String? { subAdministrativeArea }
    /// zip code, eg. 95014
    var zipCode: String? { postalCode }
    /// postal address formatted
    @available(iOS 11.0, *)
    var postalAddressFormatted: String? {
        guard let postalAddress = postalAddress else { return nil }
        return CNPostalAddressFormatter().string(from: postalAddress)
    }
}

extension CLLocation {
    func placemark(completion: @escaping (_ placemark: CLPlacemark?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first, $1) }
    }
}


func GetAddress(Lat : Double , Long : Double , completion: @escaping (String) -> ()){
    
    var Address = ""
    var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
    center.latitude = Lat
    center.longitude = Long

    let location = CLLocation(latitude: center.latitude, longitude: center.longitude)
    location.placemark { placemark, error in
        guard let placemark = placemark else {
            print("Error:", error ?? "nil")
            return
        }
        
        print("name:", placemark.name ?? "unknown")
        
        print("address1:", placemark.thoroughfare ?? "unknown")
        print("address2:", placemark.subThoroughfare ?? "unknown")
        print("neighborhood:", placemark.subLocality ?? "unknown")
        print("city:", placemark.locality ?? "unknown")
        
        print("state:", placemark.administrativeArea ?? "unknown")
        print("subAdministrativeArea:", placemark.subAdministrativeArea ?? "unknown")
        print("zip code:", placemark.postalCode ?? "unknown")
        print("country:", placemark.country ?? "unknown", terminator: "\n\n")
        
        print("isoCountryCode:", placemark.isoCountryCode ?? "unknown")
        print("region identifier:", placemark.region?.identifier ?? "unknown")

        print("timezone:", placemark.timeZone ?? "unknown", terminator:"\n\n")

        print(placemark.postalAddressFormatted ?? "")
        
        if !(placemark.name?.isEmpty ?? true) {
            Address.append(placemark.name ?? "")
        }
        if !(placemark.locality?.isEmpty ?? true) {
            Address.append(", \(placemark.locality ?? "")")
        }
        if !(placemark.postalCode?.isEmpty ?? true) {
            Address.append(", \(placemark.postalCode ?? "")")
        }
        if !(placemark.country?.isEmpty ?? true) {
            Address.append(", \(placemark.country ?? "")")
        }
        completion(Address)
    }
}

let geocoder = CLGeocoder()
