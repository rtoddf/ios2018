import UIKit

class PersonCell:UICollectionViewCell {
    var person:Person? {
        didSet {
            guard let name = person?.name else { return }
            guard let bio = person?.bio else { return }
            guard let birthDate = person?.birthDate else { return }
            guard let imageName = person?.imageName else { return }
            
            personNameLabel.text = name
            personDescriptionLabel.text = bio
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
        personIV.image = UIImage(named: "tom-daley")
        personIV.contentMode = .scaleAspectFill
        personIV.clipsToBounds = true
        return personIV
    }()
    
    let personNameLabel:UILabel = {
        let label = UILabel()
        label.text = "Tom Daley"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.numberOfLines = 2
        return label
    }()
    
    let personDescriptionLabel:UILabel = {
        let label = UILabel()
        label.text = "British driver"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hexString: "#333333")
        return label
    }()
    
    let personBirthdateLabel:UILabel = {
        let label = UILabel()
        label.text = "21 May 1994"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hexString: "#666666")
        return label
    }()
    
    func setupViews(){
//        backgroundColor = .orange
        
        addSubview(personImageView)
        addSubview(personNameLabel)
        addSubview(personDescriptionLabel)
        addSubview(personBirthdateLabel)
        
        personImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        personNameLabel.frame = CGRect(x: 0, y: frame.width + 2, width: frame.width, height: 20)
        personDescriptionLabel.frame = CGRect(x: 0, y: frame.width + 18, width: frame.width, height: 22)
        personBirthdateLabel.frame = CGRect(x: 0, y: frame.width + 34, width: frame.width, height: 22)
    }
}
