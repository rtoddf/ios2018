import UIKit

class ScreenShotsCell:BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // why subtract 28?
        return CGSize(width: 200, height: frame.height - 28)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(ScreenShotImageCell.self, forCellWithReuseIdentifier: cellId)
    }
}

class ScreenShotImageCell:BaseCell {
    let imageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .purple
        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: imageView)
    }
}
