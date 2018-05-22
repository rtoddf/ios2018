import UIKit

class ArticleImageLeftCell:BaseCell {
    var item:Item? {
        didSet {
            guard let parentId = item?.parentId else { return }
            guard let headline = item?.title else { return }
            guard let date = item?.date else { return }
            guard let startTime = item?.startTime else { return }
            guard let endTime = item?.endTime else { return }
            guard let venueName = item?.venueName else { return }
            guard let parentCategoryName = item?.parentCategoryName else { return }
            
            leadImageView.loadPointsLocalImageUsingParentId(imageId: parentId)
            headlineLabel.text = headline
            categoryLabel.text = parentCategoryName
            detailsLabel.text = date + "\n" + startTime + "-" + endTime + "\n" + venueName

            categoryLabel.backgroundColor = UIColor(hexString: getCategoryColor(category: parentCategoryName))
        }
    }

    let headlineLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .titleFont
        label.numberOfLines = 3
        return label
    }()
    
    let detailsLabel:UILabel = {
        let label = UILabel()
        label.font = .labelFont
        label.textColor = UIColor(hexString: "#666")
        label.numberOfLines = 4
        label.backgroundColor = .purple
        return label
    }()
    
    let leadImageView:UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor(hexString: "#333")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let categoryLabel:InsetLabel = {
        let label = InsetLabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.backgroundColor = UIColor(hexString: "#d31c1e")
        label.textColor = UIColor(hexString: "#fff")
        return label
    }()
    
    let dividerView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#999")
        return view
    }()
    
    override func setupViews() {
        addSubview(leadImageView)
        addSubview(categoryLabel)
        addSubview(headlineLabel)
        addSubview(detailsLabel)
        
        let imageWidth = frame.width / 3
        let textWidth = (imageWidth * 2) - 36
        
        addConstraintsWithFormat(format: "H:|[v0(\(imageWidth))]-12-|", views: leadImageView)
        addConstraintsWithFormat(format: "H:|[v0(\(imageWidth))]-12-|", views: categoryLabel)
        addConstraintsWithFormat(format: "V:|[v0][v1(14)]-12-|", views: leadImageView, categoryLabel)
        
        addConstraint(NSLayoutConstraint(item: headlineLabel,  attribute: .left, relatedBy: .equal, toItem: leadImageView, attribute: .right, multiplier: 1, constant: 12))
        addConstraint(NSLayoutConstraint(item: headlineLabel,  attribute: .top, relatedBy: .equal, toItem: leadImageView, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: headlineLabel,  attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: textWidth))
        
//        addConstraint(NSLayoutConstraint(item: detailsLabel, attribute: .top, relatedBy: .equal, toItem: headlineLabel, attribute: .bottom, multiplier: 1, constant: 12))
//        addConstraint(NSLayoutConstraint(item: detailsLabel, attribute: .top, relatedBy: .equal, toItem: leadImageView, attribute: .top, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: detailsLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: textWidth))
//        addConstraint(NSLayoutConstraint(item: detailsLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50))
    }

}
