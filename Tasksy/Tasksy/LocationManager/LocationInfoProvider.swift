import Foundation
import CoreLocation

class LocationInfoProvider {
    let manager = LocationManager().locationManager
    var longitude: CLLocationDegrees? {
        return manager.location?.coordinate.longitude
    }
    var latitude: CLLocationDegrees? {
        return manager.location?.coordinate.latitude
    }
}
