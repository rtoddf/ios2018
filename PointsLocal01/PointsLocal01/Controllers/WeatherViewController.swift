import UIKit

class WeatherViewController:UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var menu:Menu? {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = menu?.title
        navigationController?.navigationBar.tintColor = .white
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        
        self.navigationController?.navigationBar.tintColor = .white
        
        let weatherFeed = "http://weather.cmgdigital.com/USOH0245/"
        Weather.downloadData(feedUrl: weatherFeed)
    }

}
