import UIKit

class EventsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var articles:[Article]?
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.backgroundColor = UIColor(hexString: "#ffffff")
        collectionView?.register(ArticleImageLeftCell.self, forCellWithReuseIdentifier: cellId)
        
        navigationItem.title = "Movie Reviews"

        Article.downloadData { (articles) in
            self.articles = articles
            self.collectionView?.reloadData()
        }
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = articles?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ArticleImageLeftCell
        cell.article = articles?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let article = articles?[indexPath.item] else { return }
//        showArticleDetail(article: article)
//    }
//    
//    func showArticleDetail(article:Article) {
//        let layout = UICollectionViewFlowLayout()
//        let articleDetailViewController = ArticleDetailController(collectionViewLayout: layout)
//        articleDetailViewController.article = article
//        navigationController?.pushViewController(articleDetailViewController, animated: true)
//    }
}

