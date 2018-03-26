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
            
            // *** Create instance of `NSMutableParagraphStyle`
            let paragraphStyle = NSMutableParagraphStyle()
            // *** set LineSpacing property in points ***
            paragraphStyle.lineSpacing = 5   // Whatever line spacing you want in points
            
            let textAttributes: [NSAttributedStringKey: Any] = [
                .paragraphStyle: paragraphStyle,
                .font : UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor(hexString: "#777777")
            ]
            
            let rawHTML = Data(fullText.utf8)
            guard let attributedString = try? NSMutableAttributedString(data: rawHTML, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else { return }
            let attributedText = NSMutableAttributedString(string: attributedString.string, attributes: textAttributes)
            // add the styled attributed text to the textView
            textView.attributedText = attributedText
            
            let textViewRect = NSString(string: attributedText.string).boundingRect(with: CGSize(width:frame.width, height:.infinity), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: textAttributes, context: nil)
            
            // resize the textView with the new height
            textView.frame = CGRect(x: 14, y: 200 + 40 + 32 + 14, width: frame.width - 28, height: textViewRect.height)
            textView.sizeToFit()
            
            // send a noticication back to the cell to resize
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateArticleHeight"), object: textViewRect.height + CGFloat(420))
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
        
        leadImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: 200)
        headlineLabel.frame = CGRect(x: 14, y: 200 + 14, width: frame.width - 28, height: 40)
        authorLabel.frame = CGRect(x: 14, y: 200 + 40 + 14, width: frame.width - 28, height: 32)
        textView.frame = CGRect(x: 14, y: 200 + 40 + 32 + 14, width: frame.width - 28, height: 22)
    }
}
