import UIKit

class ItemCell:BaseCell {
    var item:Item? {
        didSet {
            guard let parentId = item?.parent_id else { return }
            guard let title = item?.title else { return }
            guard let date = item?.date else { return }
            guard let startTime = item?.start_time else { return }
            guard let endTime = item?.end_time else { return }
            guard let venueName = item?.venue_name else { return }
            guard let parentCategoryName = item?.parent_category_name else { return }
            
            imageView.loadPointsLocalImageUsingParentId(imageId: parentId)
            categoryLabel.text = parentCategoryName
            titleLabel.text = title
            detailsLabel.text = date + "\n" + startTime + "-" + endTime + "\n" + venueName
            
            categoryLabel.frame.size.width = categoryLabel.intrinsicContentSize.width + 10
            categoryLabel.frame.size.height = categoryLabel.intrinsicContentSize.height + 10
        }
    }
    
    let imageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor(hexString: "#333333")
        return iv
    }()
    
    let categoryLabel:InsetLabel = {
        let label = InsetLabel()
        label.backgroundColor = UIColor(hexString: "#222222")
        label.textColor = UIColor(hexString: "#ffffff")
        label.font = UIFont.boldSystemFont(ofSize: 13)
//        label.textAlignment = .center
        
        return label
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 3
        return label
    }()
    
    let detailsLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hexString: "#777777")
        label.numberOfLines = 4
        return label
    }()
    
    override func setupViews() {
//        backgroundColor = UIColor(hexString: "#ae0000")
        
        addSubview(categoryLabel)
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(detailsLabel)
        
        let imageWidth = frame.width
        let imageHeight = (9 / 16) * imageWidth
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: categoryLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: titleLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: detailsLabel)
        addConstraintsWithFormat(format: "V:|[v0][v1(\(imageHeight))]-8-[v2]-4-[v3]", views: categoryLabel, imageView, titleLabel, detailsLabel)
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
