import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    @Published var authStatus: CLAuthorizationStatus?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
           switch manager.authorizationStatus {
           case .authorizedWhenInUse:
               authStatus = .authorizedWhenInUse
               locationManager.requestLocation()
               break
               
           case .restricted:
               authStatus = .restricted
               break
               
           case .denied:
               authStatus = .denied
               break
               
           case .notDetermined:
               authStatus = .notDetermined
               manager.requestWhenInUseAuthorization()
               break
               
           default:
               break
           }
       }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
    }
       
       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print("error: \(error.localizedDescription)")
       }
    
       func stopLocation() {
           locationManager.stopUpdatingLocation()
       }
}
