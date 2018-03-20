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
            
            let attributedText = NSMutableAttributedString(string: summary, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.darkGray])
            textLabel.attributedText = attributedText
        }
    }
    
    let headlineLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "This is the headline"
        label.numberOfLines = 2
        return label
    }()
    
    let textLabel:UILabel = {
        let label = UILabel()
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
    
    override func setupViews() {
        backgroundColor = UIColor(hexString: "#dedede")
        
        addSubview(headlineLabel)
        addSubview(textLabel)
        addSubview(leadImageView)
        
        let imageWidth = frame.width / 3
        let textWidth = imageWidth * 2
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-[v1(\(imageWidth))]-16-|", views: headlineLabel, leadImageView)
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1]", views: headlineLabel, textLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0(\(textWidth))]", views: textLabel)
        addConstraintsWithFormat(format: "V:|-16-[v0]-16-|", views: leadImageView)
        
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
