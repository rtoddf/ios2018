import UIKit

class PointsLocalController:UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let largeCellId = "largeCellId"
    let cellId = "cellId"
    var items:[Item]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor(hexString: "#ffffff")
        navigationItem.title = "Points Local"
        
        collectionView?.register(LargeStoryCell.self, forCellWithReuseIdentifier: largeCellId)
        collectionView?.register(ItemCell.self, forCellWithReuseIdentifier: cellId)
        
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
        let count = "6"
        
        let feed = "\(feedBase)date_format=\(date_format)&time_format=\(time_format)&search=\(search)&tag=\(tag)&category=\(category)&latitude=\(latitude)&longitude=\(longitude)&radius=\(radius)&start=\(start)&end=\(end)&count=\(count)"
        
        Feed.downloadData(feedUrl: feed) { (items) in
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
        
        if indexPath.item % 3 == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCellId, for: indexPath) as! LargeStoryCell
            cell.item = items?[indexPath.item]
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ItemCell
        cell.item = items?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item % 3 == 0 {
            return CGSize(width: view.frame.width, height: 304)
        }
        
        return CGSize(width: (collectionView.frame.width/2)-5, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
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

