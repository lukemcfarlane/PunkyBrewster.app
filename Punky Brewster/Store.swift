import Foundation
import MapKit

class Store: NSObject {
    let name = "Punky Brewster"
    let url = "http://www.punkybrewster.co.nz"
    let address = "22B Tyne Street"
    let location = CLLocation(latitude: -43.5368540539132, longitude: 172.608717675136)
    
    var coordinate:CLLocationCoordinate2D {
        return location.coordinate
    }
    
    func regionWithDistance(distance:CLLocationDistance) -> MKCoordinateRegion {
        return MKCoordinateRegionMakeWithDistance(coordinate, distance, distance)
    }
}
