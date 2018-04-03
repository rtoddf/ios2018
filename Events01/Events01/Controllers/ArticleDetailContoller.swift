import UIKit

class ArticleDetailController:UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    let cellTextId = "cellTextid"
    let cellImagesId = "cellImagesId"
    let cellMapId = "cellMapId"
    // set a default var for cellHeight
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
            cell.articleDetailContoller = self
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
    
    let zoomedImageBackgroundView = UIView()
    let navCoverView = UIView()
    var leadImageView:UIImageView?
    let zoomImageView = UIImageView()
    
    // if you have a tab bar
    // https://www.youtube.com/watch?v=kzdI2aiTX4k&t=1370s - 32:30
    
    func animate(leadImageView:UIImageView){
        self.leadImageView = leadImageView
        
        leadImageView.alpha = 0
        zoomedImageBackgroundView.frame = self.view.frame
        zoomedImageBackgroundView.backgroundColor = UIColor(hexString: "#333333")
        zoomedImageBackgroundView.alpha = 0
        view.addSubview(zoomedImageBackgroundView)
        
        navCoverView.frame = CGRect(x: 0, y: 0, width: 1000, height: 20 + 44)
        navCoverView.backgroundColor = UIColor(hexString: "#333333")
        navCoverView.alpha = 0
        
        // the nav at the top is above the view, so we have to get it to add the subview
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        keyWindow.addSubview(navCoverView)
        
        guard let startingFrame = leadImageView.superview?.convert(leadImageView.frame, to: nil) else { return }
        
        zoomImageView.isUserInteractionEnabled = true
        zoomImageView.image = leadImageView.image
        zoomImageView.frame = startingFrame
        view.addSubview(zoomImageView)
        zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.animateOut)))
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            let height = (startingFrame.width / startingFrame.width) * startingFrame.height
            let y = (self.view.frame.height / 2) - (height / 2)
            
            self.zoomImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
            self.zoomedImageBackgroundView.alpha = 1
            self.navCoverView.alpha = 1
        })
        
//        UIView.animate(withDuration: 0.5) {
//            let height = (startingFrame.width / startingFrame.width) * startingFrame.height
//            let y = (self.view.frame.height / 2) - (height / 2)
//
//            self.zoomImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
//            self.zoomedImageBackgroundView.alpha = 1
//            self.navCoverView.alpha = 1
//        }
    }
    
    @objc func animateOut(){
        guard let startingFrame = leadImageView?.superview?.convert((leadImageView?.frame)!, to: nil) else { return }
    
//        UIView.animate(withDuration: 0.5) {
//            self.zoomImageView.frame = startingFrame
//            self.zoomedImageBackgroundView.alpha = 0
//        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.zoomImageView.frame = startingFrame
            self.zoomedImageBackgroundView.alpha = 0
            self.navCoverView.alpha = 0
        }) { (didComplete) in
            self.zoomImageView.removeFromSuperview()
            self.zoomedImageBackgroundView.removeFromSuperview()
            self.navCoverView.removeFromSuperview()
            self.leadImageView?.alpha = 1
        }
    }
}

//extension ArticleDetailController: UpdateArticleHeight {
//    func newHeight() {
//        <#code#>
//    }
//
//
//}

