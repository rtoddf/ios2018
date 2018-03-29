import UIKit
import MapKit
import CoreLocation

class ArticleDetailMapCell:BaseCell, MKMapViewDelegate {    
    var article:Article? {
        didSet {
            
        }
    }
    
    let articleMap:MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        
        let latitude:CLLocationDegrees = 35.4823225
        let longitude:CLLocationDegrees = -97.7600733
        
        let latDelta = 0.025
        let lonDelta = 0.025
        
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta:latDelta, longitudeDelta:lonDelta)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude:latitude, longitude:longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegion(center:location, span:span)
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = "Jimmy Carter Presidential Library and Museum"
        annotation.subtitle = "The museum includes photographs"
        annotation.coordinate = location
        map.addAnnotation(annotation)

        return map
    }()
    
    override func setupViews() {
        addSubview(articleMap)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: articleMap)
        addConstraintsWithFormat(format: "V:|[v0]|", views: articleMap)
    }
    
}
