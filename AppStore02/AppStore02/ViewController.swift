import UIKit

class FeaturedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let largeCellId = "largeCellId"
    var categories:[Category]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        categories = Category.samplePeopleCategories()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(LargeCategoryCell.self, forCellWithReuseIdentifier: largeCellId)
        
        Category.downloadData { (categories) in
            self.categories = categories
            self.collectionView?.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = categories?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCellId, for: indexPath) as! LargeCategoryCell
            
            if let cats = categories {
                cell.category  = cats[indexPath.item]
            }
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        
        if let cats = categories {
            cell.category  = cats[indexPath.item]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 2 {
            return CGSize(width: view.frame.width, height: 160)
        }
        
        return CGSize(width: view.frame.width, height: 230)
    }
}
