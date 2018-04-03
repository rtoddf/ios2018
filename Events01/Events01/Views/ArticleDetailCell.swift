import UIKit

//protocol UpdateArticleHeight {
//    func newHeight () -> Void
//}

class ArticleDetailCell:BaseCell {
//    var delegate: UpdateArticleHeight!
    var articleDetailContoller:ArticleDetailController?
    
    @objc func animateView(){
        print("click one")
        articleDetailContoller?.animate(leadImageView: leadImageView)
        
        //        UIView.animate(withDuration: 0.75) {
        //            let height = (self.view.frame.width / self.startingFrame.width) * self.startingFrame.height
        //            let y = (self.view.frame.height / 2) - (height / 2)
        //
        //            self.zoomImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
        //        }
    }
    
    var article:Article? {
        didSet {
            guard let leadImage = article?.lead_image else { return }
            guard let publishedDate = article?.pub_date else { return }
            guard let headline = article?.headline else { return }
            guard let author = article?.author else { return }
            
            leadImageView.loadImageUsingUrlString(imageUrl: leadImage)
            headlineLabel.text = headline
            
            var authorText = "By "
            authorText.append("\(author) | \(publishedDate)")
            authorLabel.text = authorText
        }
    }
    
    let leadImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
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
    
    override func setupViews() {
        addSubview(leadImageView)
        addSubview(headlineLabel)
        addSubview(authorLabel)
        
        let imageWidth = frame.width
        let imageHeight = (9 / 16) * imageWidth
        
        leadImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.animateView)))
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: leadImageView)
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: headlineLabel)
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: authorLabel)

        addConstraintsWithFormat(format: "V:|[v0(\(imageHeight))]-8-[v1(40)]-14-[v2]", views: leadImageView, headlineLabel, authorLabel)
    }
}

class ArticleDetailTextCell:BaseCell {
    var article:Article? {
        didSet {
            guard let fullText = article?.full_text else { return }
            
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
            
            let textViewRect = NSString(string: attributedText.string).boundingRect(with: CGSize(width:frame.width - 28, height:.infinity), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: textAttributes, context: nil)
            
            // resize the textView with the new height
            textView.frame = CGRect(x: 14, y: 14, width: frame.width - 28, height: textViewRect.height + CGFloat(48))
            textView.sizeToFit()
            
            //            delegate.newHeight()
            
            // send a noticication back to the cell to resize
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateArticleHeight"), object: textViewRect.height + CGFloat(48))
        }
    }
    
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
        addSubview(textView)
        
        textView.frame = CGRect(x: 14, y: 14, width: frame.width - 28, height: 200)
    }
}

// extra code

//let textAttributes: [NSAttributedStringKey: Any] = [
//    .strokeColor : UIColor.black,
//    .foregroundColor : UIColor.white,
//    .strokeWidth : -2.0,
//    .paragraphStyle: paragraphStyle,
//    .font : UIFont.systemFont(ofSize: 14),
//    .foregroundColor: UIColor(hexString: "#777777")
//]

// *** Apply attribute to string ***
//            attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedText.length))

// make a var so we can use it easily in the boundingRect calculations
//            let attributes: [NSAttributedStringKey: Any] = [
//                .font: UIFont.systemFont(ofSize: 14),
//                .paragraphStyle: paragraphStyle
//            ]



//        addConstraintsWithFormat(format: "H:|[v0]|", views: leadImageView)
//        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: headlineLabel)
//        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: authorLabel)
//        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: textView)
//
//        addConstraintsWithFormat(format: "V:|[v0(200)]-8-[v1(50)]-4-[v2(20)]-8-[v3]|", views: leadImageView, headlineLabel, authorLabel, textView)
