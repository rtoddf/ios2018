import UIKit

class ItemCell:BaseCell {
    var item:Item? {
        didSet {
            guard let title = item?.title else { return }
            guard let date = item?.date else { return }
            guard let startTime = item?.start_time else { return }
            guard let endTime = item?.end_time else { return }
            guard let venueName = item?.venue_name else { return }
            guard let parentCategoryName = item?.parent_category_name else { return }
            
            categoryLabel.text = parentCategoryName
            titleLabel.text = title
            detailsLabel.text = date + "\n" + startTime + "-" + endTime + "\n" + venueName
            
            categoryLabel.frame.size.width = categoryLabel.intrinsicContentSize.width + 10
            categoryLabel.frame.size.height = categoryLabel.intrinsicContentSize.height + 10
        }
    }
    
    let categoryLabel:InsetLabel = {
        let label = InsetLabel()
        label.backgroundColor = UIColor(hexString: "#003264")
        label.textColor = UIColor(hexString: "#ffffff")
        label.font = UIFont.systemFont(ofSize: 13)
//        label.textAlignment = .center
        
        return label
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
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
        addSubview(titleLabel)
        addSubview(detailsLabel)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: categoryLabel)
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: titleLabel)
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: detailsLabel)
        addConstraintsWithFormat(format: "V:|[v0]-14-[v1]-8-[v2]", views: categoryLabel, titleLabel, detailsLabel)
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
