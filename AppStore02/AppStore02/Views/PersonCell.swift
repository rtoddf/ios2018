import UIKit

class PersonCell:UICollectionViewCell {
    var person:Person? {
        didSet {
            guard let name = person?.name else { return }
            guard let shiortBio = person?.short_bio else { return }
            guard let birthDate = person?.birth_date else { return }
            guard let imageName = person?.imageName else { return }
            
            personNameLabel.text = name
            
            let personNameLabelRect = NSString(string: name).boundingRect(with: CGSize(width:frame.width, height:1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 13)], context: nil)
            
            if personNameLabelRect.height > 22 {
                personShortBioLabel.frame = CGRect(x: 0, y: frame.width + 30, width: frame.width, height: 32)
                personBirthdateLabel.frame = CGRect(x: 0, y: frame.width + 52, width: frame.width, height: 22)
            } else {
                personShortBioLabel.frame = CGRect(x: 0, y: frame.width + 14, width: frame.width, height: 32)
                personBirthdateLabel.frame = CGRect(x: 0, y: frame.width + 36, width: frame.width, height: 22)
            }
            
            personNameLabel.frame = CGRect(x: 0, y: frame.width + 5, width: frame.width, height: 40)
            personNameLabel.sizeToFit()
            
            personShortBioLabel.text = shiortBio
            personBirthdateLabel.text = birthDate
            
            
            
            personImageView.loadImageUsingUrlString(imageUrl: imageName)
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
//        label.numberOfLines = 2
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
        personNameLabel.frame = CGRect(x: 0, y: frame.width + 2, width: frame.width, height: 40)
        personShortBioLabel.frame = CGRect(x: 0, y: frame.width + 30, width: frame.width, height: 32)
        personBirthdateLabel.frame = CGRect(x: 0, y: frame.width + 52, width: frame.width, height: 22)
    }
}

class LargePersonCell:PersonCell {
    override func setupViews() {
        addSubview(personImageView)
        personImageView.translatesAutoresizingMaskIntoConstraints = false
        personImageView.layer.borderColor = UIColor(hexString: "#333333").cgColor
        personImageView.layer.borderWidth = 0.5
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: [
            "v0": personImageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-2-[v0]-14-|", options: NSLayoutFormatOptions(), metrics: nil, views: [
            "v0": personImageView]))
    }
}
