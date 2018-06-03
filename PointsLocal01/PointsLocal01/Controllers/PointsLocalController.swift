import UIKit

class PointsLocalController:UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let imageLargeCellId = "imageLargeCellId"
    let imageLeftCellId = "imageLeftCellId"
    let imageRightCellId = "imageRightCellId"
    let imageTopCellId = "imageTopCellId"
    var items:[Item]?
    var events:[Item]?
    
    var categoryCellHeightDiff:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor(hexString: "#ffffff")
        navigationItem.title = "Points Local"
        
        collectionView?.register(ArticleImageLargeCell.self, forCellWithReuseIdentifier: imageLargeCellId)
        collectionView?.register(ArticleImageLeftCell.self, forCellWithReuseIdentifier: imageLeftCellId)
        collectionView?.register(ArticleImageRightCell.self, forCellWithReuseIdentifier: imageRightCellId)
        collectionView?.register(ArticleImageTopCell.self, forCellWithReuseIdentifier: imageTopCellId)
        
        let feedBase = "https://dayton.pointslocal.com/api/v1/events?"
        let date_format = "F%20j,%20Y"
        let time_format = "g:i%20a"
        let search = "festival"
        let tag = ""
        let category = ""
        let latitude = "39.7794694"
        let longitude = "-84.2721968"
        let radius = "25"
        let start = "today"
        let end = "+30%20days"
        let count = "14"
        
        let feed = "\(feedBase)date_format=\(date_format)&time_format=\(time_format)&search=\(search)&tag=\(tag)&category=\(category)&latitude=\(latitude)&longitude=\(longitude)&radius=\(radius)&start=\(start)&end=\(end)&count=\(count)"
        
//        Feed.downloadData(feedUrl: feed) { (items) in
//            self.items = items
//            self.collectionView?.reloadData()
//        }
        
        Events.downloadData(feedUrl: feed) { (items) in
            self.items = items
            self.collectionView?.reloadData()
        }

        collectionView?.dataSource = self
        collectionView?.delegate = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = items?.count else { return 0 }
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item % 7 == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageLargeCellId, for: indexPath) as! ArticleImageLargeCell
            cell.item = items?[indexPath.item]
            return cell
        }
        
        if indexPath.item % 7 == 1 || indexPath.item % 7 == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageRightCellId, for: indexPath) as! ArticleImageRightCell
            cell.item = items?[indexPath.item]
            return cell
        }
        
        if indexPath.item % 7 == 3 || indexPath.item % 7 == 4 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageLeftCellId, for: indexPath) as! ArticleImageLeftCell
            cell.item = items?[indexPath.item]
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageTopCellId, for: indexPath) as! ArticleImageTopCell
        cell.item = items?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item % 7 == 0 {
            return CGSize(width: view.frame.width, height: 304 - categoryCellHeightDiff)
        }

        if indexPath.item % 7 == 1 || indexPath.item % 7 == 2 {
            return CGSize(width: view.frame.width, height: 120)
        }
        
        if indexPath.item % 7 == 3 || indexPath.item % 7 == 4 {
            return CGSize(width: view.frame.width, height: 120)
        }
        
        return CGSize(width: (view.frame.width/2), height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsetsMake(0, 0, 0, 0)
//    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = items?[indexPath.item] else { return }
        showArticleDetail(item: item)
    }
    
    func showArticleDetail(item: Item){
        let layout = UICollectionViewFlowLayout()
        let itemDetailViewController = ItemDetailViewController(collectionViewLayout: layout)
        itemDetailViewController.item = item
        navigationController?.pushViewController(itemDetailViewController, animated: true)
    }
}

