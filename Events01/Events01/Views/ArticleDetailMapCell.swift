import UIKit
import MapKit
import CoreLocation

class ArticleDetailMapCell:BaseCell, MKMapViewDelegate {    
    var article:Article? {
        didSet {
            guard let latitude = article?.locations![0].latitude else { return }
            guard let longitude = article?.locations![0].longitude else { return }
            guard let name = article?.locations![0].name else { return }
            
            let longitudnalMeters:CLLocationDistance = 50000
            let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude:CLLocationDegrees(latitude), longitude:CLLocationDegrees(longitude))
            let region:MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(location, longitudnalMeters, longitudnalMeters)

            articleMap.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.title = name
            annotation.coordinate = location
            articleMap.addAnnotation(annotation)
            
            let yourAnnotationAtIndex = 0
            articleMap.selectAnnotation(articleMap.annotations[yourAnnotationAtIndex], animated: true)
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


//            let latDelta = 50.0
//            let lonDelta = 50.0
//            let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta:latDelta, longitudeDelta:lonDelta)
//                MKCoordinateRegion(center:location, span:span)
