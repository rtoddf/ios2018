import UIKit

class ArticleImageRightCell:BaseCell {
    var article:Article? {
        didSet {
            guard let leadImage = article?.lead_image else { return }
            guard let headline = article?.headline else { return }
            guard let publishedDate = article?.pub_date else { return }
            guard let summary = article?.summary else { return }
            
            leadImageView.loadImageUsingUrlString(imageUrl: leadImage)
            headlineLabel.text = headline
            authorLabel.text = publishedDate
            
            let attributedText = NSMutableAttributedString(string: summary, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor.darkGray])
            textLabel.attributedText = attributedText
        }
    }
    
    let headlineLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    
    let textLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let authorLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hexString: "#777777")
        return label
    }()
    
    let leadImageView:UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor(hexString: "#333333")
        iv.contentMode = .scaleAspectFill
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
        addSubview(authorLabel)
        addSubview(dividerView)
        
        let imageWidth = frame.width / 3
        let textWidth = (imageWidth * 2) - 36
        
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-[v1(\(imageWidth))]-12-|", views: headlineLabel, leadImageView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: dividerView)
        addConstraintsWithFormat(format: "V:|-12-[v0]-12-[v1(0.5)]|", views: leadImageView, dividerView)

        addConstraint(NSLayoutConstraint(item: headlineLabel,  attribute: .top, relatedBy: .equal, toItem: leadImageView, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: headlineLabel,  attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: textWidth))

        addConstraint(NSLayoutConstraint(item: textLabel,  attribute: .left, relatedBy: .equal, toItem: headlineLabel, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: textLabel,  attribute: .top, relatedBy: .equal, toItem: headlineLabel, attribute: .bottom, multiplier: 1, constant: 4))
        addConstraint(NSLayoutConstraint(item: textLabel,  attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: textWidth))

        addConstraint(NSLayoutConstraint(item: authorLabel,  attribute: .left, relatedBy: .equal, toItem: headlineLabel, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: authorLabel,  attribute: .bottom, relatedBy: .equal, toItem: leadImageView, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: authorLabel,  attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: textWidth))
    }
    
}
