import UIKit

class PersonCell:UICollectionViewCell {
    var person:Person? {
        didSet {
            guard let name = person?.name else { return }
            guard let shiortBio = person?.bio else { return }
            guard let birthDate = person?.birthDate else { return }
            guard let imageName = person?.imageName else { return }
            
            personNameLabel.text = name
            personShortBioLabel.text = shiortBio
            personBirthdateLabel.text = birthDate
            personImageView.image = UIImage(named: imageName)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let personImageView:UIImageView = {
        let personIV = UIImageView()
        personIV.contentMode = .scaleAspectFill
        personIV.clipsToBounds = true
        return personIV
    }()
    
    let personNameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.numberOfLines = 2
        return label
    }()
    
    let personShortBioLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hexString: "#333333")
        return label
    }()
    
    let personBirthdateLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hexString: "#666666")
        return label
    }()
    
    func setupViews(){
        addSubview(personImageView)
        addSubview(personNameLabel)
        addSubview(personShortBioLabel)
        addSubview(personBirthdateLabel)
        
        personImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        personNameLabel.frame = CGRect(x: 0, y: frame.width + 2, width: frame.width, height: 20)
        personShortBioLabel.frame = CGRect(x: 0, y: frame.width + 18, width: frame.width, height: 22)
        personBirthdateLabel.frame = CGRect(x: 0, y: frame.width + 34, width: frame.width, height: 22)
    }
}
