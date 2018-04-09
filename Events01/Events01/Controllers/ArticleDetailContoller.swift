import UIKit

class ArticleDetailController:UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    let cellTextId = "cellTextid"
    let cellImagesId = "cellImagesId"
    let cellMapId = "cellMapId"
    let cellRelatedId = "cellRelatedId"
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
        collectionView?.register(ArticleRelatedCell.self, forCellWithReuseIdentifier: cellRelatedId)
        
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
        return 5
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
        
        if indexPath.item == 4 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellRelatedId, for: indexPath) as! ArticleRelatedCell
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
        
        if indexPath.item == 4 {
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
    let imageInfoLabel = UILabel()
    
    // if you have a tab bar
    // https://www.youtube.com/watch?v=kzdI2aiTX4k&t=1370s - 32:30

    func animate(image:UIImageView, title:String, caption:String, credit:String){
        // can you create ane extension for this?

        // tweak zoomed images for animateOut and ratios
        // try passing the image rather than the view - this might help with the dimensions
        // padding on UILabel - https://gist.github.com/danielkagemann/f2e9a069a910dc92ddbc94f889f137a5
        
        // pick a better name than MyTapGesture and move it to Helpers if possible
        // your date and author are running into the text - fix this
        
        // you found the answer to myTapGesture here: https://stackoverflow.com/questions/38445262/pass-parameter-with-uitapgesturerecognizer
        
        // see if you can tweak the attributedtext stuff
        
        self.image = image
        
        image.alpha = 0
        
        // blackbackground
        zoomedImageBackgroundView.frame = self.view.frame
        zoomedImageBackgroundView.backgroundColor = UIColor(hexString: "#333333")
        zoomedImageBackgroundView.alpha = 0
        view.addSubview(zoomedImageBackgroundView)
        
        // navcover
        navCoverView.frame = CGRect(x: 0, y: 0, width: 1000, height: 20 + 44)
        navCoverView.backgroundColor = UIColor(hexString: "#333333")
        navCoverView.alpha = 0
        
        // the nav at the top is above the view, so we have to get it to add the subview
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        keyWindow.addSubview(navCoverView)
        
        // zoomedImage
        guard let startingFrame = image.superview?.convert(image.frame, to: nil) else { return }
        zoomImageView.isUserInteractionEnabled = true
        zoomImageView.image = image.image
        zoomImageView.frame = startingFrame
        view.addSubview(zoomImageView)
        zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.animateOut)))

        // imageInfoLabel
        imageInfoLabel.frame = CGRect(x: 14, y: view.frame.height, width: view.frame.width - 28, height: imageInfoLabel.bounds.size.height)
        imageInfoLabel.backgroundColor = UIColor(hexString: "#333333").withAlphaComponent(0.7)
        imageInfoLabel.numberOfLines = 0
        imageInfoLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        imageInfoLabel.alpha = 0
        
        let imageInfoAttributedString = NSMutableAttributedString()
        imageInfoAttributedString
            .format(string: title + "\n", font: "AvenirNext-Bold", textSize: 14, textColor: UIColor(hexString: "#dedede"), linespacing: 1)
            .format(string: caption + "\n", font: "AvenirNext-Medium", textSize: 13, textColor: UIColor(hexString: "#dedede"), linespacing: 1)
            .format(string: credit, font: "AvenirNext-Italic", textSize: 12, textColor: UIColor(hexString: "#dedede"), linespacing: 1)
        
        imageInfoLabel.attributedText = imageInfoAttributedString
        imageInfoLabel.sizeToFit()
        view.addSubview(imageInfoLabel)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            let width:CGFloat
            let height:CGFloat
            let x:CGFloat
            let y:CGFloat
            
            if Int((self.zoomImageView.image?.size.height)!) > Int((self.zoomImageView.image?.size.width)!) {
                width = (self.view.safeAreaLayoutGuide.layoutFrame.size.height / (image.image?.size.height)!) * (image.image?.size.width)!
                height = self.view.safeAreaLayoutGuide.layoutFrame.size.height
                x = (self.view.frame.width / 2) - (width / 2)
                y = self.navCoverView.frame.height
            } else {
                width = self.view.frame.width
                height = (self.view.frame.width / startingFrame.width) * startingFrame.height
                x = 0
                y = (self.view.frame.height / 2) - (height / 2)
            }
            
            self.zoomImageView.frame = CGRect(x: x, y: y, width: width, height: height)
            self.imageInfoLabel.alpha = 1
            self.imageInfoLabel.frame = CGRect(x: 14, y: self.view.frame.height - self.imageInfoLabel.bounds.size.height - 14, width: self.view.frame.width - 28, height: self.imageInfoLabel.bounds.size.height)
            self.zoomedImageBackgroundView.alpha = 1
            self.navCoverView.alpha = 1
        })
    }
    
    @objc func animateOut(){
        guard let startingFrame = image?.superview?.convert((image?.frame)!, to: nil) else { return }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.zoomImageView.frame = startingFrame
            self.imageInfoLabel.alpha = 0
            self.imageInfoLabel.frame = CGRect(x: 14, y: self.view.frame.height, width: self.view.frame.width - 28, height: self.imageInfoLabel.bounds.size.height)
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

