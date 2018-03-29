import UIKit
import MapKit
import CoreLocation

class ArticleDetailMapCell:BaseCell, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    var article:Article? {
        didSet {
            
        }
    }
    
    let map:MKMapView = {
        let theMap = MKMapView()
        theMap.backgroundColor = UIColor(hexString: "#ae0000")
        theMap.translatesAutoresizingMaskIntoConstraints = false
        return theMap
    }()
    
    override func setupViews() {
        addSubview(map)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: map)
        addConstraintsWithFormat(format: "V:|[v0]|", views: map)
    }
    
}
