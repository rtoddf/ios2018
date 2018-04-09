import UIKit

class ArticleRelatedCell:BaseCell, UITableViewDataSource, UITableViewDelegate {
    let storyCellId = "storyCellId"
    
    var article:Article? {
        didSet {
            
        }
    }
    
    let headerLabel:UILabel = {
        let label = UILabel()
        label.text = "Related Content"
        label.font = UIFont(name: "AvenirNext-Bold", size: 18.0)
        return label
    }()
    
    let tableView:UITableView = {
        let displayWidth: CGFloat = 200
        let displayHeight: CGFloat = 480
        
        let tv = UITableView()

        return tv
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = article?.related_content?.count {
            if count <= 4 {
                return count
            }
        }
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: storyCellId, for: indexPath) as! RelatedTableCell
        
        if let relatedContent = article?.related_content {
            cell.item = relatedContent[indexPath.item]
        }

        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80.0
//    }
    
    override func setupViews() {
        addSubview(headerLabel)
        addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RelatedTableCell.self, forCellReuseIdentifier: storyCellId)

        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: headerLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: tableView)
        addConstraintsWithFormat(format: "V:|[v0]-8-[v1(320)]", views: headerLabel, tableView)
    }
}

class RelatedTableCell:UITableViewCell {
    var item:Item? {
        didSet {
            guard let headline = item?.headline else { return }
            guard let image = item?.lead_image else { return }
            
            headlineLabel.text = headline
            articleImageView.loadImageUsingUrlString(imageUrl: image)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var headlineLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.numberOfLines = 2
        return label
    }()

    let articleImageView:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor(hexString: "#333333")
        return iv
    }()
    
    func setupViews(){
        addSubview(headlineLabel)
        addSubview(articleImageView)
        
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-[v1(64)]-14-|", views: headlineLabel, articleImageView)
        addConstraintsWithFormat(format: "V:|-8-[v0]", views: headlineLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0(64)]-8-|", views: articleImageView)
    }
}
