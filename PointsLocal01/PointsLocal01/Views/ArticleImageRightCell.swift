import UIKit

class ArticleImageRightCell:BaseCell {
    var item:Item? {
        didSet {
            guard let parentId = item?.parentId else { return }
            guard let headline = item?.headline else { return }
            guard let date = item?.date else { return }
            guard let startTime = item?.startTime else { return }
            guard let endTime = item?.endTime else { return }
            guard let venueName = item?.venueName else { return }
            guard let parentCategoryName = item?.parentCategoryName else { return }
            
            leadImageView.loadPointsLocalImageUsingParentId(imageId: parentId)
            headlineLabel.text = headline
            categoryLabel.text = parentCategoryName
            detailsLabel.text = date + "\n" + startTime + "-" + endTime + "\n" + venueName
            
            categoryLabel.backgroundColor = UIColor(hexString: getCategoryColor(group: group, category: parentCategoryName))
        }
    }
    
    let headlineLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .eventHeadlineFont
        label.numberOfLines = 3
        return label
    }()
    
    let detailsLabel:UILabel = {
        let label = UILabel()
        label.font = .eventDetailsFont
        label.textColor = UIColor(hexString: "#666")
        label.numberOfLines = 4
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
    
    let detailView:UIView = {
        let view = UIView()
        return view
    }()
    
    override func setupViews() {
        addSubview(detailView)
        addSubview(leadImageView)
//        addSubview(categoryLabel)
        
        detailView.addSubview(headlineLabel)
        detailView.addSubview(detailsLabel)
        
        let imageWidth = frame.width / 3
        let textWidth = (imageWidth * 2) - 36
        
        addConstraintsWithFormat(format: "H:|-12-[v0(\(textWidth))]-12-[v1(\(imageWidth))]-12-|", views: detailView, leadImageView)
//        addConstraintsWithFormat(format: "H:|[v0(\(imageWidth))]-12-|", views: categoryLabel)
        addConstraintsWithFormat(format: "V:|[v0]-12-|", views: detailView)
        addConstraintsWithFormat(format: "V:|[v0]-12-|", views: leadImageView)
        
        addConstraintsWithFormat(format: "H:|-2-[v0]-2-|", views: headlineLabel)
        addConstraintsWithFormat(format: "H:|-2-[v0]-2-|", views: detailsLabel)
        addConstraintsWithFormat(format: "V:|-2-[v0]-4-[v1]", views: headlineLabel, detailsLabel)
    }
    
}
