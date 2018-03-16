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
            authorLabel.text = authorText
            dateLabel.text = publishedDate
            
            let attributedText = NSMutableAttributedString(string: summary, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.darkGray])
            textLabel.attributedText = attributedText
        }
    }
    
    let leadImageView:UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8.0
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let headlineLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        return label
    }()
    
    let authorLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hexString: "#777777")
        return label
    }()
    
    let textLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        return label
    }()
    
    let dateLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hexString: "#777777")
        return label
    }()
    
    override func setupViews() {
        backgroundColor = .clear
        
        addSubview(leadImageView)
        addSubview(headlineLabel)
        addSubview(authorLabel)
        addSubview(textLabel)
        addSubview(dateLabel)
        
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: leadImageView)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: headlineLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: authorLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: textLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: dateLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0(100)]-8-[v1]-4-[v2]-8-[v3]-16-[v4]", views: leadImageView, headlineLabel, authorLabel, textLabel, dateLabel)
        
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
