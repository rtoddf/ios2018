import UIKit

class ItemDetailHeaderCell:BaseCell {
    var item:Item? {
        didSet {
            guard let parentId = item?.parent_id else { return }
//            guard let title = item?.title else { return }
//            guard let date = item?.date else { return }
//            guard let startTime = item?.start_time else { return }
//            guard let endTime = item?.end_time else { return }
//            guard let venueName = item?.venue_name else { return }
//            guard let parentCategoryName = item?.parent_category_name else { return }
            
            imageView.loadPointsLocalImageUsingParentId(imageId: parentId)
        }
    }
    
    let imageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor(hexString: "#333333")
        return iv
    }()
    
    override func setupViews() {
        addSubview(imageView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
        addConstraintsWithFormat(format: "V:|[v0(\((9 / 16) * frame.width))]", views: imageView)
    }
    
}
