import UIKit
import MapKit
import CoreLocation

var latitude:CLLocationDegrees = 35.4823225
var longitude:CLLocationDegrees = -97.7600733
let longitudnalMeters:CLLocationDistance = 50000
let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude:CLLocationDegrees(latitude), longitude:CLLocationDegrees(longitude))
let region:MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(location, longitudnalMeters, longitudnalMeters)

class ArticleDetailMapCell:BaseCell, MKMapViewDelegate {
    var article:Article? {
        didSet {
            guard let articleLatitude = article?.locations![0].latitude else { return }
            guard let articleLongitude = article?.locations![0].longitude else { return }
            guard let articleName = article?.locations![0].name else { return }
            
            let articleLocation:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude:CLLocationDegrees(articleLatitude), longitude:CLLocationDegrees(articleLongitude))
            let articleRegion:MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(articleLocation, longitudnalMeters, longitudnalMeters)
            
            articleMap.setRegion(articleRegion, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.title = articleName
            annotation.coordinate = articleLocation
            articleMap.addAnnotation(annotation)
            
            let yourAnnotationAtIndex = 0
            articleMap.selectAnnotation(articleMap.annotations[yourAnnotationAtIndex], animated: true)
        }
    }
    
    let articleMap:MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
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
