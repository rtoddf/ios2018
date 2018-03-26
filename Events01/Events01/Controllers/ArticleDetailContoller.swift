import UIKit

class ArticleDetailController:UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
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
        
        self.navigationController?.navigationBar.tintColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateArticleHeight), name: NSNotification.Name(rawValue: "UpdateArticleHeight"), object: nil)
    }
    
    @objc func updateArticleHeight(notification: Notification) {
        guard let height = notification.object as? CGFloat else { return }
        
        cellHeight = height
        print("cellHeight: \(cellHeight)")
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ArticleDetailCell
        cell.article = article
//        cell.delegate = self
        return cell
    }
    
    // this needs to be resized
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: cellHeight)
    }
    
    
}

//extension ArticleDetailController: UpdateArticleHeight {
//    func newHeight() {
//        <#code#>
//    }
//
//
//}

