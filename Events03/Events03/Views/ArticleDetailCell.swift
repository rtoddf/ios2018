import UIKit

class ArticleDetailCell:BaseCell {
    var article:Article? {
        didSet {
            guard let leadImage = article?.lead_image else { return }
            guard let publishedDate = article?.pub_date else { return }
            guard let headline = article?.headline else { return }
            guard let author = article?.author else { return }
            guard let fullText = article?.full_text else { return }
            
            leadImageView.loadImageUsingUrlString(imageUrl: leadImage)
            headlineLabel.text = headline
            
            var authorText = "By "
            authorText.append("\(author) | \(publishedDate)")
            authorLabel.text = authorText
            
            let rawHTML = Data(fullText.utf8)
            let textAttributes: [NSAttributedStringKey: Any] = [
                //                .strokeColor : UIColor.black,
                //                .foregroundColor : UIColor.white,
                //                .strokeWidth : -2.0,
                .font : UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor(hexString: "#777777")
            ]
            
            guard let attributedString = try? NSMutableAttributedString(data: rawHTML, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else { return }
            let attributedText = NSMutableAttributedString(string: attributedString.string, attributes: textAttributes)
            
            // *** Create instance of `NSMutableParagraphStyle`
            let paragraphStyle = NSMutableParagraphStyle()
            
            // *** set LineSpacing property in points ***
            paragraphStyle.lineSpacing = 3 // Whatever line spacing you want in points
            
            // *** Apply attribute to string ***
            attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedText.length))
            
            textView.attributedText = attributedText
        }
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
    
    let textView:UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        //        textView.textContainerInset = .zero
        textView.contentInset = UIEdgeInsetsMake(0, -5, 0, 0)
        textView.isSelectable = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override func setupViews() {
        addSubview(leadImageView)
        addSubview(headlineLabel)
        addSubview(authorLabel)
        addSubview(textView)
        
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: leadImageView)
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: headlineLabel)
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: authorLabel)
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: textView)
        
        addConstraintsWithFormat(format: "V:|[v0(200)]-8-[v1(50)]-4-[v2(20)]-8-[v3]|", views: leadImageView, headlineLabel, authorLabel, textView)
    }
}

