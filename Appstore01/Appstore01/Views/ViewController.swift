// https://www.youtube.com/watch?v=Ko9oNhlTwH0&list=PL0dzCUj1L5JEXct3-OV6itP7Kz3tRDmma&index=1&t=38s
// https://www.youtube.com/watch?v=uLb8cs11h_g&list=PL0dzCUj1L5JEXct3-OV6itP7Kz3tRDmma&index=2 - 15:13

import UIKit

class FeaturedAppsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    var appCategories:[AppCategory]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appCategories = AppCategory.sampleAppCategories()
        collectionView?.backgroundColor = .white
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let appCats = appCategories {
            return appCats.count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        
        cell.appCategory = appCategories?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 230)
    }

}
