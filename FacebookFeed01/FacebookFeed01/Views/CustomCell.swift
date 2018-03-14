import UIKit

class CustomCell:UICollectionViewCell {
    var person: Person? {
        didSet {
            guard let name = person?.name else { return }
            guard let description = person?.description else { return }
            let attributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
            attributedText.append(NSAttributedString(string: description, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor(hexString: "#666666")]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
            
            nameLabel.attributedText = attributedText
            //        label.font = UIFont.boldSystemFont(ofSize: 14)
            //        label.translatesAutoresizingMaskIntoConstraints = false
            
            guard let profileImage = person?.profileImage else { return }
            profileImageView.loadImageUsingUrlString(imageUrl: profileImage)
            
            guard let statusImage = person?.statusImage else { return }
            statusImageView.loadImageUsingUrlString(imageUrl: statusImage)
            
            guard let statusText = person?.statusText else { return }
            statusTextView.text = statusText
            
            guard let subStatusText = person?.subStatusText else { return }
            subStatusLabel.text = subStatusText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    let profileImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(hexString: "#333333")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let statusTextView:UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isScrollEnabled = false
        textView.isSelectable = false
        return textView
    }()
    
    let statusImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let subStatusLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#777777")
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let separatorView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#999999")
        return view
    }()
    
    let buttonStackView:UIStackView = {
        var stack = UIStackView()
        stack.distribution = .fillEqually
        
        let likeButton:UIButton = buttonGenerator(title: "Like", imageName: "home")
        let commentButton:UIButton = buttonGenerator(title: "Comment", imageName: "home")
        let shareButton:UIButton = buttonGenerator(title: "Share", imageName: "home")
        
        stack.addArrangedSubview(likeButton)
        stack.addArrangedSubview(commentButton)
        stack.addArrangedSubview(shareButton)
        
        return stack
    }()
    
    func setupViews(){
        backgroundColor = UIColor(hexString: "#ffffff")
        let statusImageHeight = frame.width * (9/16)
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(subStatusLabel)
        addSubview(separatorView)
        addSubview(buttonStackView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, nameLabel)
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: statusTextView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: statusImageView)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: subStatusLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: buttonStackView)
        
        addConstraintsWithFormat(format: "V:|-8-[v0]", views: nameLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0(44)]-4-[v1]-4-[v2(\(statusImageHeight))]-8-[v3(24)]-8-[v4(0.4)][v5(44)]|", views: profileImageView, statusTextView, statusImageView, subStatusLabel, separatorView, buttonStackView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
