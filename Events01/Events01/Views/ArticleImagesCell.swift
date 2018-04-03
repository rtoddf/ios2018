import UIKit

// https://www.youtube.com/watch?v=kzdI2aiTX4k&t=1370s - 17:11

class ArticleImagesCell:BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"

    var article:Article? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let dividerView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#ae0000")
        return view
    }()
    
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        layout.scrollDirection = .horizontal
        return cv
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = article?.images?.count {
            return count
        }

        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ImageCell
        
        if let image = article?.images![indexPath.item].path {
            cell.articleImageView.loadImageUsingUrlString(imageUrl: image)
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = frame.width * 0.40
        let height = (9 / 16) * width
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    override func setupViews() {
        super.setupViews()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        addSubview(dividerView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: dividerView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0(0.5)][v1]|", views: dividerView, collectionView)
    }
}

class ImageCell:BaseCell {
    let articleImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor(hexString: "#333333")
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(articleImageView)

        addConstraintsWithFormat(format: "H:|[v0]|", views: articleImageView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: articleImageView)
    }
}
