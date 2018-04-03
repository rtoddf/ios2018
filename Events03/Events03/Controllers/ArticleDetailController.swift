import UIKit

class ArticleDetailController:UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    let cellTextId = "cellTextId"
    let cellImagesId = "cellImagesId"
    let cellMapId = "cellMapId"
    var cellHeight:CGFloat = 22.0
    
    var article:Article? {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(ArticleDetailCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(ArticleDetailTextCell.self, forCellWithReuseIdentifier: cellTextId)
        collectionView?.register(ArticleImagesCell.self, forCellWithReuseIdentifier: cellImagesId)
        collectionView?.register(ArticleDetailMapCell.self, forCellWithReuseIdentifier: cellMapId)
        
        self.navigationController?.navigationBar.tintColor = .white
        
        // create the notification and add observer
        NotificationCenter.default.addObserver(self, selector: #selector(updateArticleHeight), name: NSNotification.Name(rawValue: "UpdateArticleHeight"), object: nil)
    }
    
    @objc func updateArticleHeight(notification: Notification) {
        guard let height = notification.object as? CGFloat else { return }
        cellHeight = height
        // redraw the collectionView using invalidateLayout
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ArticleDetailCell
            cell.article = article
            return cell
        }
        
        if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellImagesId, for: indexPath) as! ArticleImagesCell
            cell.article = article
            return cell
        }
        
        if indexPath.item == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellMapId, for: indexPath) as! ArticleDetailMapCell
            cell.article = article
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellTextId, for: indexPath) as! ArticleDetailTextCell
        cell.article = article
        //        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: view.frame.width, height: 265)
        }
        
        if indexPath.item == 2 {
            let height = (9 / 16) * (view.frame.width * 0.40) + 28
            return CGSize(width: view.frame.width, height: height)
        }
        
        if indexPath.item == 3 {
            return CGSize(width: view.frame.width, height: 200)
        }
        
        // use the var for the height to be set after notification sent
        return CGSize(width: view.frame.width, height: cellHeight)
    }
}
