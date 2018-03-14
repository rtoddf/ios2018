// ep1 - https://www.youtube.com/watch?v=NJxb7EKXF3U&list=PL0dzCUj1L5JHDWIO3x4wePhD8G4d1Fa6N&index=1
// ep2 - https://www.youtube.com/watch?v=ZwBYQpLQAvw&list=PL0dzCUj1L5JHDWIO3x4wePhD8G4d1Fa6N&index=2
// ep3 - https://www.youtube.com/watch?v=L9cZrAbxN1E&list=PL0dzCUj1L5JHDWIO3x4wePhD8G4d1Fa6N&index=3
// ep4 - https://www.youtube.com/watch?v=1Sg7HjR_k2c&t=19s
// ep5 - https://www.youtube.com/watch?v=kzdI2aiTX4k
// https://www.raywenderlich.com/99087/swift-expanding-cells-ios-collection-views
// https://medium.com/@adinugroho/fixed-height-uicollectionview-inside-uitableview-79f24657d08f
// https://coderwall.com/p/dyqrfa/customize-navigation-bar-appearance-with-swift
// https://grokswift.com/json-swift-4/

import UIKit

let cellId = "cellId"

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var people = [Person]()
    
    func downloadJSON() {
        let jsonUrlString = "http://www.rtodd.net/swift/data/facebook.json"
        let url = URL(string: jsonUrlString)
        
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            // take care of error
            
            guard let data = data else { return }
            
            do {
                let people  = try JSONDecoder().decode([Person].self, from:data)
                self.people = people
                
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
        downloadJSON()
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor(hexString: "#efefef")
        navigationItem.title = "Facebook Feed"
        collectionView?.register(CustomCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CustomCell
        // reference post
        cell.person = people[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let statusImageHeight = view.frame.width * (9/16)
        
        if let statusText = people[indexPath.item].statusText {
            let rectConstraint = CGSize(width: view.frame.width, height: 1000)
            let rectOptions = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
            let rectAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
            let rect = NSString(string: statusText).boundingRect(with: rectConstraint, options: rectOptions, attributes: rectAttributes, context: nil)
            let rectHeight = rect.height + (8 + 44 + 4 + 4 + statusImageHeight + 8 + 24 + 8 + 1 + 44) + 16
            
            return CGSize(width: view.frame.width, height: rectHeight)
        }
        
        return CGSize(width: view.frame.width, height: 500)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}
