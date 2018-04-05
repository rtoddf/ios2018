import UIKit

class EventsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    var articles:[Article]?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Movie Reviews"
        
        collectionView?.backgroundColor = UIColor(hexString: "#ffffff")
        collectionView?.register(LargeStoryCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.alwaysBounceVertical = true

        Article.downloadData { (articles) in
            self.articles = articles
            self.collectionView?.reloadData()
        }
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
//        printFonts()

        let stringDate:String = "Thu, 05 Apr 2018 16:21:00 EDT"
        print("time: \(stringDate.timeAgoDisplay())")
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = articles?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LargeStoryCell
        cell.article = articles?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 375)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let article = articles?[indexPath.item] else { return }
        showArticleDetail(article: article)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func showArticleDetail(article: Article){
        let layout = UICollectionViewFlowLayout()
        let articleDetailViewController = ArticleDetailController(collectionViewLayout: layout)
        articleDetailViewController.article = article
        navigationController?.pushViewController(articleDetailViewController, animated: true)
    }
}



