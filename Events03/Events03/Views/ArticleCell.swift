import UIKit

class ArticleCell:BaseCell {
    
    override func setupViews() {
        backgroundColor = UIColor(hexString: "#baba71")
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
