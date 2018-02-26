import UIKit

class AppCell:UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let personImageView:UIImageView = {
        let personIV = UIImageView()
        personIV.image = UIImage(named: "tom-daley")
        personIV.contentMode = .scaleAspectFill
        personIV.clipsToBounds = true
        return personIV
    }()
    
    func setupViews(){
//        backgroundColor = .orange
        
        addSubview(personImageView)
        personImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
    }
}
