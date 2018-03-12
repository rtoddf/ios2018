import UIKit

class PersonDetailController:UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var person:Person? {
        didSet {

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
            guard let personName = person?.name else { return }
            nameLabel.text = personName
            guard let shortBio = person?.short_bio else { return }
            shortBioLabel.sizeToFit()
            shortBioLabel.text = shortBio
            
            guard let birthDate = person?.birth_date else { return }
            birthDateLabel.text = birthDate
        }
    }
    
    let imageView:UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .orange
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let shortBioLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.backgroundColor = .orange
        return label
    }()
    
    let birthDateLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let segmentedControl:UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Details", "Reviews", "Related"])
        sc.tintColor = UIColor(hexString: "#777777")
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    let dividerLineView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#666666")
        return view
    }()
    
    override func setupViews() {
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(shortBioLabel)
        addSubview(birthDateLabel)
        addSubview(segmentedControl)
        addSubview(dividerLineView)

        addConstraintsWithFormat(format: "H:|-14-[v0(100)]-14-[v1]", views: imageView, nameLabel)
        addConstraintsWithFormat(format: "V:|-14-[v0]-2-[v1(60)]-2-[v2]", views: nameLabel, shortBioLabel, birthDateLabel)
        addConstraintsWithFormat(format: "H:|-128-[v0]", views: shortBioLabel)
        addConstraintsWithFormat(format: "H:|-128-[v0]", views: birthDateLabel)
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: segmentedControl)
        addConstraintsWithFormat(format: "H:|[v0]|", views: dividerLineView)
        addConstraintsWithFormat(format: "V:|-14-[v0(100)]-16-[v1]-[v2(0.4)]|", views: imageView, segmentedControl, dividerLineView)
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


