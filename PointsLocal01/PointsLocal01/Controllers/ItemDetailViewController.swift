import UIKit

class ItemDetailViewController:UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var item:Item? {
        didSet {
            
        }
    }
    
    let headerCellId = "headerCellId"

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.register(ItemDetailHeaderCell.self, forCellWithReuseIdentifier: headerCellId)
        
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: headerCellId, for: indexPath) as! ItemDetailHeaderCell
        cell.item = item
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: (9 / 16) * view.frame.width)
    }
    
}
