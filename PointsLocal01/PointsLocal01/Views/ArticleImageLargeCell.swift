import UIKit

class ArticleImageLargeCell:BaseCell {
    var item:Item? {
        didSet {
            guard let parentId = item?.parentId else { return }
            guard let headline = item?.headline else { return }
            guard let date = item?.date else { return }
            guard let startTime = item?.startTime else { return }
            guard let endTime = item?.endTime else { return }
            guard let venueName = item?.venueName else { return }
            guard let parentCategoryName = item?.parentCategoryName else { return }
            
            guard let summary = item?.fullText else { return }
            
            leadImageView.loadPointsLocalImageUsingParentId(imageId: parentId)
//            headlineLabel.text = headline
            categoryLabel.text = parentCategoryName
            categoryLabel.backgroundColor = UIColor(hexString: getCategoryColor(group: group, category: parentCategoryName))

//            guard let summaryText = summary.htmlAttributedString else { return }
//            textLabel.text = summaryText.string
//
//            detailsLabel.text = date + "\n" + startTime + "-" + endTime + " @ " + venueName
        }
    }

    let leadImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let categoryLabel:InsetLabel = {
        let label = InsetLabel()
        label.font = .boldLabelFont
        label.backgroundColor = UIColor(hexString: "#d31c1e")
        label.textColor = UIColor(hexString: "#fff")
        return label
    }()
    
    let leadArticleInfoView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#444")
        return view
    }()
    
    let headlineLabel:UILabel = {
        let label = UILabel()
        label.font = .titleFont
        label.numberOfLines = 2
        label.textColor = UIColor(hexString: "#000")
        return label
    }()
    
    let textLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = .bodyFont
        label.textColor = UIColor(hexString: "#444")
        return label
    }()
    
    let detailsLabel:UILabel = {
        let label = UILabel()
        label.font = .bodyFont
        label.textColor = UIColor(hexString: "#444")
        label.numberOfLines = 4
        return label
    }()
    
    override func setupViews(){
        addSubview(leadImageView)
        addSubview(categoryLabel)
        addSubview(leadArticleInfoView)
//        addSubview(headlineLabel)
//        addSubview(textLabel)
//        addSubview(detailsLabel)
        
        let imageWidth = frame.width
        let imageHeight = (9 / 16) * imageWidth
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: leadImageView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: categoryLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: leadArticleInfoView)
//        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: headlineLabel)
//        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: textLabel)
//        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: detailsLabel)
        addConstraintsWithFormat(format: "V:|[v0(200)][v1(22)][v2]-20-|", views: leadImageView, categoryLabel, leadArticleInfoView)
        
    }

}
