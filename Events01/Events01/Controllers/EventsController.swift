import UIKit

class EventsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    var articles:[Article]?
    
    func downloadJSON() {
        let jsonUrlString = "http://www.rtodd.net/swift/data/events.json"
        let url = URL(string: jsonUrlString)
        
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            // take care of error
            
            guard let data = data else { return }
            
            do {
                let articles  = try JSONDecoder().decode([Article].self, from:data)
                self.articles = articles
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            } catch let jsonErr {
                print("error serializing JSON:", jsonErr)
            }
            }.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Movie Reviews"
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(LargeStoryCell.self, forCellWithReuseIdentifier: cellId)
        
        downloadJSON()
        
//        Article.downloadData { (articles) in
//            self.articles = articles
//
//            print("articles from event controller: \(articles.items.count)")
//
//            self.collectionView?.reloadData()
//        }
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LargeStoryCell
        cell.article = articles?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 375)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}


















