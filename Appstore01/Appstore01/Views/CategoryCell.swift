import UIKit

class CategoryCell:UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var appCategory:AppCategory? {
        didSet {
            guard let categoryName = appCategory?.name else { return }
            categoryLabel.text = categoryName
        }
    }

    let cellId = "cellId"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategory?.apps?.count {
            return count
        }

        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppCell
        cell.app = appCategory?.apps?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: frame.height - 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }

    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let categoryLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Actors"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let appsCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let borderView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#ae0000")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupViews(){
        appsCollectionView.delegate = self
        appsCollectionView.dataSource = self
        appsCollectionView.register(AppCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(categoryLabel)
        addSubview(appsCollectionView)
        addSubview(borderView)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[v0]-12-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": categoryLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appsCollectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": borderView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(30)][v1]-[v2(0.5)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": categoryLabel, "v1": appsCollectionView, "v2": borderView]))
    }
}
