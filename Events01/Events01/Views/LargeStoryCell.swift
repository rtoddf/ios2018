import UIKit

class LargeStoryCell:UICollectionViewCell {
    var article:Article? {
        didSet {
            guard let headline = article?.headline else { return }
            guard let author = article?.author else { return }
            guard let fullText = article?.full_text else { return }
            guard let leadImage = article?.lead_image else { return }
            
            leadImageView.loadImageUsingUrlString(imageUrl: leadImage)
            headlineLabel.text = headline
            authorLabel.text = author

            let attributedText = NSMutableAttributedString(string: fullText, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.darkGray])
            textLabel.attributedText = attributedText
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let leadImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let headlineLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        return label
    }()
    
    let authorLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hexString: "#777777")
        return label
    }()
    
    let textLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        return label
        
        //        let style = NSMutableParagraphStyle()
        //        style.lineSpacing = 20
        //
        //        let range = NSMakeRange(0, attributedText.string.count)
        //        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: range)
        
        //        label.text = "Steven Spielberg’s new film adaptation of Ready Player One prominently features that same car, but in a context that improves it immensely. Spielberg doesn’t have Wade talk audiences through it, and he doesn’t spell out the references. He just slaps the car down in the middle of a tremendous early action scene, where it’s prominent, distinctive, and memorable. Fans who want the full nostalgia trip, who want to wring every Easter egg out of the experience, will eventually be able to pause the movie and frame-by-frame through it, looking for the flux capacitor on the dashboard, checking the plates, and scanning for extra bonus material. But in the middle of the action, even to people who’ve never seen the Back to the Future movies and aren’t vibing on the connection, the car doesn’t need explaining. It’s just a sleek piece of visual energy, one breathless element among dozens of others. It’s not a citation or a list. It’s an effortless, integrated piece of the action."
        //        label.font = UIFont.systemFont(ofSize: 14)
        //        label.textColor = UIColor(hexString: "#444444")
        
    }()
    
    let textView:UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
    }()

    let userInteractionStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        
        let shareButton = createButton(title: "Share")
        let saveButton = createButton(title: "Save")
        let favoriteButton = createButton(title: "Fave")
        stackView.addArrangedSubview(shareButton)
        stackView.addArrangedSubview(saveButton)
        stackView.addArrangedSubview(favoriteButton)
        
        return stackView
    }()

    func setupViews(){
        addSubview(leadImageView)
        addSubview(headlineLabel)
        addSubview(authorLabel)
        addSubview(textLabel)
        addSubview(userInteractionStackView)
        //        addSubview(textView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: leadImageView)
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: headlineLabel)
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: authorLabel)
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: textLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: userInteractionStackView)
        addConstraintsWithFormat(format: "V:|[v0(200)]-8-[v1]-4-[v2]-8-[v3]-12-[v4]", views: leadImageView, headlineLabel, authorLabel, textLabel, userInteractionStackView)
    }
}
