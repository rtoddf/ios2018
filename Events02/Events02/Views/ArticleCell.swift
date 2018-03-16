import UIKit

class ArticleCell:BaseCell {
    var article:Article? {
        didSet {
            guard let headline = article?.headline else { return }
            
            headlineLabel.text = headline
        }
    }
    
    let leadImageView:UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor(hexString: "#ae0000")
        iv.layer.cornerRadius = 8.0
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let headlineLabel:UILabel = {
        let label = UILabel()
        label.text = "Have You Seen 'A Wrinkle in Time'? Let's Talk"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        return label
    }()
    
    let authorLabel:UILabel = {
        let label = UILabel()
        label.text = "By"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hexString: "#777777")
        return label
    }()
    
    override func setupViews() {
        backgroundColor = .clear
        
        addSubview(leadImageView)
        addSubview(headlineLabel)
        addSubview(authorLabel)
        
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: leadImageView)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: headlineLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: authorLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0(100)]-8-[v1]-4-[v2]", views: leadImageView, headlineLabel, authorLabel)
        
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
