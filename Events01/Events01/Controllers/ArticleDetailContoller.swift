import UIKit

class ArticleDetailController:UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    
    var article:Article? {
        didSet {

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(DetailCell.self, forCellWithReuseIdentifier: cellId)
        
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DetailCell
        cell.article = article
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 1000)
    }
}

class DetailCell:BaseCell {
    var article:Article? {
        didSet {
            guard let leadImage = article?.lead_image else { return }
            guard let headline = article?.headline else { return }
            guard let author = article?.author else { return }
            guard let fullText = article?.full_text else { return }

            leadImageView.loadImageUsingUrlString(imageUrl: leadImage)
            headlineLabel.text = headline
            authorLabel.text = author
            
            var html = "<style>p{margin:10px}</style>"
            html.append(fullText)
            
            let rawHTML = Data(html.utf8)

            guard let attributedString = try? NSMutableAttributedString(data: rawHTML, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else { return }
            let attributedText = NSMutableAttributedString(string: attributedString.string, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.darkGray])
            textView.attributedText = attributedText
        }
    }
    
    let leadImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .brown
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

class BaseCell:UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        
    }
}
