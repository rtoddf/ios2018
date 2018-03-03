// 15:32

import UIKit

class FeaturedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let largeCellId = "largeCellId"
    let headerCellId = "headerCellId"
    var categories:[Category]?
    var banner:[Banner]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Featured Guys"

        collectionView?.backgroundColor = .white
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(LargeCategoryCell.self, forCellWithReuseIdentifier: largeCellId)
        collectionView?.register(Header.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellId)
        
        Banner.downloadData { (banner) in
            self.banner = banner
            self.collectionView?.reloadData()
        }
        
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
            
            cell.featuredPersonController = self
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        
        if let cats = categories {
            cell.category  = cats[indexPath.item]
        }
        
        cell.featuredPersonController = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 2 {
            return CGSize(width: view.frame.width, height: 170)
        }

        return CGSize(width: view.frame.width, height: 230)
    }
    
    func showPersonDetailForPerson(person: Person){
        let layout = UICollectionViewFlowLayout()
        let personViewController = PersonDetailController(collectionViewLayout: layout)
        navigationController?.pushViewController(personViewController, animated: true)
    }
    
    // headerview
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 140)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellId, for: indexPath) as! Header
        
        if let ban = banner {
            cell.banner = ban[indexPath.item]
        }

        return cell
    }
}
