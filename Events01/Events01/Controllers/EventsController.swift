import UIKit

class EventsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Movie Reviews"
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(EventCell.self, forCellWithReuseIdentifier: cellId)
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
}

class EventCell:UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let leadImageView:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "ready-player-one")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let headlineLabel:UILabel = {
        let label = UILabel()
        label.text = "Steven Spielberg’s Ready Player One improves immensely on the book"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 2
        return label
    }()
    
    let authorLabel:UILabel = {
        let label = UILabel()
        label.text = "By: Tasha Robinson"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hexString: "#777777")
        return label
    }()
    
    let textLabel:UILabel = {
        let label = UILabel()
        
        let text = "Steven Spielberg’s new film adaptation of Ready Player One prominently features that same car, but in a context that improves it immensely. Spielberg doesn’t have Wade talk audiences through it, and he doesn’t spell out the references. He just slaps the car down in the middle of a tremendous early action scene, where it’s prominent, distinctive, and memorable. Fans who want the full nostalgia trip, who want to wring every Easter egg out of the experience, will eventually be able to pause the movie and frame-by-frame through it, looking for the flux capacitor on the dashboard, checking the plates, and scanning for extra bonus material. But in the middle of the action, even to people who’ve never seen the Back to the Future movies and aren’t vibing on the connection, the car doesn’t need explaining. It’s just a sleek piece of visual energy, one breathless element among dozens of others. It’s not a citation or a list. It’s an effortless, integrated piece of the action."
        
        let attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.darkGray])
        label.attributedText = attributedText
        
    //        let style = NSMutableParagraphStyle()
    //        style.lineSpacing = 20
    //        
    //        let range = NSMakeRange(0, attributedText.string.count)
    //        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: range)
        
//        label.text = "Steven Spielberg’s new film adaptation of Ready Player One prominently features that same car, but in a context that improves it immensely. Spielberg doesn’t have Wade talk audiences through it, and he doesn’t spell out the references. He just slaps the car down in the middle of a tremendous early action scene, where it’s prominent, distinctive, and memorable. Fans who want the full nostalgia trip, who want to wring every Easter egg out of the experience, will eventually be able to pause the movie and frame-by-frame through it, looking for the flux capacitor on the dashboard, checking the plates, and scanning for extra bonus material. But in the middle of the action, even to people who’ve never seen the Back to the Future movies and aren’t vibing on the connection, the car doesn’t need explaining. It’s just a sleek piece of visual energy, one breathless element among dozens of others. It’s not a citation or a list. It’s an effortless, integrated piece of the action."
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.textColor = UIColor(hexString: "#444444")
        label.numberOfLines = 4
        return label
    }()
    
    let textView:UITextView = {
        let textView = UITextView()
        textView.text = "Ernest Cline’s fast-moving novel was a treasure trove for pop-culture junkies, but the endless references work better on the screen"
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
    }()
    
    func setupViews(){
        addSubview(leadImageView)
        addSubview(headlineLabel)
        addSubview(authorLabel)
        addSubview(textLabel)
//        addSubview(textView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: leadImageView)
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: headlineLabel)
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: authorLabel)
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: textLabel)
        addConstraintsWithFormat(format: "V:|[v0(200)]-8-[v1]-4-[v2]-8-[v3]", views: leadImageView, headlineLabel, authorLabel, textLabel)
    }
}
















