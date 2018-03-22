import UIKit

class ArticleCell:BaseCell {
    var article:Article? {
        didSet {
            guard let leadImage = article?.lead_image else { return }
            guard let headline = article?.headline else { return }
            guard let publishedDate = article?.pub_date else { return }
            guard let author = article?.author else { return }
            guard let summary = article?.summary else { return }
            
            leadImageView.loadImageUsingUrlString(imageUrl: leadImage)
            headlineLabel.text = headline
            var authorText = "By "
            authorText.append(author)
//            authorLabel.text = authorText
//            dateLabel.text = publishedDate
            
            let attributedText = NSMutableAttributedString(string: summary, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor.darkGray])
            textLabel.attributedText = attributedText
        }
    }
    
    let headlineLabel:UILabel = {
        let label = UILabel()
//        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 3
        return label
    }()
    
    let textLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is the headline"
        label.numberOfLines = 2
        return label
    }()
    
    let leadImageView:UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor(hexString: "#333333")
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    let dividerView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#999999")
        return view
    }()
    
    override func setupViews() {
        backgroundColor = UIColor(hexString: "#ffffff")
        
        addSubview(leadImageView)
        addSubview(headlineLabel)
        addSubview(textLabel)
        addSubview(dividerView)
        
        
        let imageWidth = frame.width / 3
        let textWidth = imageWidth * 2
        
        addConstraintsWithFormat(format: "H:|-12-[v0(\(imageWidth))]-12-|", views: leadImageView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: dividerView)
        addConstraintsWithFormat(format: "V:|-12-[v0]-12-[v1(0.5)]|", views: leadImageView, dividerView)
        
        addConstraint(NSLayoutConstraint(item: headlineLabel,  attribute: .left, relatedBy: .equal, toItem: leadImageView, attribute: .right, multiplier: 1, constant: 12))
        addConstraint(NSLayoutConstraint(item: headlineLabel,  attribute: .top, relatedBy: .equal, toItem: leadImageView, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: headlineLabel,  attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: textWidth-36))
        
        addConstraint(NSLayoutConstraint(item: textLabel,  attribute: .left, relatedBy: .equal, toItem: headlineLabel, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: textLabel,  attribute: .top, relatedBy: .equal, toItem: headlineLabel, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: textLabel,  attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: textWidth-36))
        

//        addConstraintsWithFormat(format: "V:|-16-[v0]", views: headlineLabel)
        
//        addConstraintsWithFormat(format: "H:|-16-[v0]-16-[v1(\(imageWidth))]-16-|", views: headlineLabel, leadImageView)
//        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1]", views: headlineLabel, textLabel)
//        addConstraintsWithFormat(format: "H:|-16-[v0(\(textWidth))]", views: textLabel)
//        addConstraintsWithFormat(format: "V:|-16-[v0]-16-|", views: leadImageView)
        
        // top constraint
//        addConstraint(NSLayoutConstraint(item: textLabel,  attribute: .top, relatedBy: .equal, toItem: headlineLabel, attribute: .bottom, multiplier: 1, constant: 2))
//        // left constraint
//        addConstraint(NSLayoutConstraint(item: textLabel,  attribute: .left, relatedBy: .equal, toItem: headlineLabel, attribute: .left, multiplier: 0, constant: 0))
//        // right constraint
//        addConstraint(NSLayoutConstraint(item: textLabel,  attribute: .right, relatedBy: .equal, toItem: headlineLabel, attribute: .right, multiplier: 0, constant: 0))
//        // height constraint
//        addConstraint(NSLayoutConstraint(item: textLabel,  attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 100))
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
