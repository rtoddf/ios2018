import UIKit

class EventsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var articles:[Article]?
    let cellId = "cellId"
    let cellIdRight = "cellIdRight"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.backgroundColor = UIColor(hexString: "#ffffff")
        collectionView?.register(ArticleImageLeftCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(ArticleImageRightCell.self, forCellWithReuseIdentifier: cellIdRight)
        
        navigationItem.title = "Heading"

        Article.downloadData { (articles) in
            self.articles = articles
            self.collectionView?.reloadData()
        }
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = articles?.count {
            return count % 2 == 0 ? count : count - 1
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        find a better way
        if indexPath.item < 2 || indexPath.item > 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdRight, for: indexPath) as! ArticleImageRightCell
            cell.article = articles?[indexPath.item]
            return cell
        }

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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let article = articles?[indexPath.item] else { return }
        showArticleDetail(article: article)
    }
    
    func showArticleDetail(article:Article) {
        let layout = UICollectionViewFlowLayout()
        let articleDetailViewController = ArticleDetailController(collectionViewLayout: layout)
        articleDetailViewController.article = article
        navigationController?.pushViewController(articleDetailViewController, animated: true)
    }
}

