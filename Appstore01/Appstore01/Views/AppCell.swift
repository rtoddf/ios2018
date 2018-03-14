import UIKit

class AppCell:UICollectionViewCell {
    var app:App? {
        didSet {
            guard let name = app?.name else { return }
            guard let info = app?.info else { return }
            guard let birthdate = app?.date else { return }
            guard let imageName = app?.imageName else { return }
            
            nameLabel.text = name
            infoLabel.text  = info
            dateLabel.text  = birthdate
            appImageView.image = UIImage(named: imageName)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let appImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
//        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let infoLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hexString: "#333333")
        label.numberOfLines = 2
        return label
    }()
    
    let dateLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor(hexString: "#666666")
        return label
    }()
    
    func setupViews(){
        addSubview(appImageView)
        addSubview(nameLabel)
        addSubview(infoLabel)
        addSubview(dateLabel)
        
        appImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        nameLabel.frame = CGRect(x: 0, y: frame.width, width: frame.width, height: 40)
        infoLabel.frame = CGRect(x: 0, y: frame.width + 26, width: frame.width, height: 40)
        dateLabel.frame = CGRect(x: 0, y: frame.width + 62, width: frame.width, height: 20)
//
//        let width = frame.width
//
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appImageView]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": infoLabel]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dateLabel]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(\(width))]-8-[v1(16)]-[v2]-[v3(10)]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appImageView, "v1": nameLabel, "v2": infoLabel, "v3": dateLabel]))
    }
}
