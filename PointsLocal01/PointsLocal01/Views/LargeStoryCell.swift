import UIKit

class LargeStoryCell:BaseCell {
    var item:Item? {
        didSet {
            guard let parentId = item?.parentId else { return }
            guard let title = item?.title else { return }
            guard let parentCategoryName = item?.parentCategoryName else { return }
            
            leadImageView.loadPointsLocalImageUsingParentId(imageId: parentId)
            
        }
    }

    let leadImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let categoryLabel:UILabel = {
        let label = UILabel()
        label.font = .boldLabelFont
        label.backgroundColor = UIColor(hexString: "#d31c1e")
        label.textColor = UIColor(hexString: "#fff")
        return label
    }()
    
    let headlineLabel:UILabel = {
        let label = UILabel()
        label.font = .titleFont
        label.numberOfLines = 2
        label.textColor = UIColor(hexString: "#fff")
        return label
    }()
    
    override func setupViews(){
        addSubview(leadImageView)
        addSubview(categoryLabel)
        addSubview(headlineLabel)
        
        let imageWidth = frame.width
        let imageHeight = (9 / 16) * imageWidth
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: categoryLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: leadImageView)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: headlineLabel)
        addConstraintsWithFormat(format: "V:|[v0][v1(\(imageHeight))]-8-[v2]", views: categoryLabel, leadImageView, headlineLabel)
        
    }

}
