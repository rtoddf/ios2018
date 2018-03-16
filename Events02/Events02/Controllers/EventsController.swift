import UIKit

class EventsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var articles:[Article]?
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Movie Reviews"
        
        collectionView?.backgroundColor = UIColor(hexString: "#ffffff")
        collectionView?.register(ArticleCell.self, forCellWithReuseIdentifier: cellId)
    
        Article.downloadData { (articles) in
            self.articles = articles
            self.collectionView?.reloadData()
        }
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = articles?.count else { return 0 }
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ArticleCell
        cell.article = articles?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width/2)-5, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}

