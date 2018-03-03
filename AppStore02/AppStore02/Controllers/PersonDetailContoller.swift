import UIKit

class PersonDetailController:UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var person:Person? {
        didSet {
            navigationItem.title = person?.name
        }
    }
    
    let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.register(PersonDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PersonDetailHeader
        
        header.person = person
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 170)
    }
}


class PersonDetailHeader:BaseCell {
    
    var person:Person? {
        didSet {
            guard let imageName = person?.imageName else { return }
            imageView.loadImageUsingUrlString(imageUrl: imageName)
        }
    }
    
    let imageView:UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .orange
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override func setupViews() {

        addSubview(imageView)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0(100)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-14-[v0(100)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
    }
}

class BaseCell:UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews(){
        
    }
}


