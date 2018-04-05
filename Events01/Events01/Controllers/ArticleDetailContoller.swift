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
//            cell.articleDetailContoller = self
            return cell
        }
        
        if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellImagesId, for: indexPath) as! ArticleImagesCell
            cell.article = article
            cell.articleDetailContoller = self
            
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
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    let zoomedImageBackgroundView = UIView()
    let navCoverView = UIView()
    var image:UIImageView?
    let zoomImageView = UIImageView()
    let captionLabel = UILabel()
    
    // if you have a tab bar
    // https://www.youtube.com/watch?v=kzdI2aiTX4k&t=1370s - 32:30

    func animate(image:UIImageView, title:String, caption:String, credit:String){
        // can you create ane extension for this?
        // you need to take care of the vertical vs horizontal images - https://stackoverflow.com/questions/23068862/how-to-detect-if-image-is-landscape-from-uiimagepicker
        // do an attributed text box for the title, caption, and credit
        
        
        
        // pick a better name than MyTapGesture and move it to Helpers if possible
        // your date and author are running into the text - fix this
        // try passing the image rather than the view - this might help with the dimensions
        // you found the answer to myTapGesture here: https://stackoverflow.com/questions/38445262/pass-parameter-with-uitapgesturerecognizer
        
        self.image = image
        
        image.alpha = 0
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
        
        guard let startingFrame = image.superview?.convert(image.frame, to: nil) else { return }
        
        zoomImageView.isUserInteractionEnabled = true
        zoomImageView.image = image.image
        zoomImageView.frame = startingFrame
        view.addSubview(zoomImageView)
        zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.animateOut)))
        
        captionLabel.frame = CGRect(x: 14, y: view.frame.height - 120, width: view.frame.width - 18, height: 120)
        captionLabel.numberOfLines = 3
        captionLabel.text = caption
        captionLabel.textColor = UIColor(hexString: "#ffffff")
        captionLabel.font = UIFont.systemFont(ofSize: 14)
        captionLabel.alpha = 0
        view.addSubview(captionLabel)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
            let y = (self.view.frame.height / 2) - (height / 2)
            
            self.zoomImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
            self.captionLabel.alpha = 1
            self.zoomedImageBackgroundView.alpha = 1
            self.navCoverView.alpha = 1
        })
    }
    
    @objc func animateOut(){
        guard let startingFrame = image?.superview?.convert((image?.frame)!, to: nil) else { return }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.zoomImageView.frame = startingFrame
            self.captionLabel.alpha = 0
            self.zoomedImageBackgroundView.alpha = 0
            self.navCoverView.alpha = 0
        }) { (didComplete) in
            self.zoomImageView.removeFromSuperview()
            self.zoomedImageBackgroundView.removeFromSuperview()
            self.navCoverView.removeFromSuperview()
            self.image?.alpha = 1
        }
    }
}

//        UIView.animate(withDuration: 0.5) {
//            let height = (startingFrame.width / startingFrame.width) * startingFrame.height
//            let y = (self.view.frame.height / 2) - (height / 2)
//
//            self.zoomImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
//            self.zoomedImageBackgroundView.alpha = 1
//            self.navCoverView.alpha = 1
//        }

//        UIView.animate(withDuration: 0.5) {
//            self.zoomImageView.frame = startingFrame
//            self.zoomedImageBackgroundView.alpha = 0
//        }

//extension ArticleDetailController: UpdateArticleHeight {
//    func newHeight() {
//        <#code#>
//    }
//
//
//}

