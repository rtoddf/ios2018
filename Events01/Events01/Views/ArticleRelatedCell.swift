import UIKit

class ArticleRelatedCell:BaseCell, UITableViewDataSource, UITableViewDelegate {
    let storyCellId = "storyCellId"
    
    var article:Article? {
        didSet {
            
        }
    }
    
    let dividerView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#ae0000")
        return view
    }()
    
    let headerLabel:UILabel = {
        let label = UILabel()
        label.text = "Related Content"
        label.font = UIFont(name: "AvenirNext-Bold", size: 18.0)
        return label
    }()
    
    let tableView:UITableView = {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = 200
        let displayHeight: CGFloat = 200
        
        let tv = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
//        tableView.
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
        if let headline = article?.related_content![indexPath.item].headline,
            let image = article?.related_content![indexPath.item].lead_image {
            cell.nameLabel.text = headline
            cell.articleImageView.loadImageUsingUrlString(imageUrl: image)
        }
//        if let image = article?.images![indexPath.item].path
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    override func setupViews() {
        addSubview(dividerView)
        addSubview(headerLabel)
        addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RelatedTableCell.self, forCellReuseIdentifier: storyCellId)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: dividerView)
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: headerLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: tableView)
        addConstraintsWithFormat(format: "V:|[v0(0.5)]-8-[v1]-8-[v2(200)]", views: dividerView, headerLabel, tableView)
    }
}

class RelatedTableCell:UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var nameLabel:UILabel = {
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
        addSubview(nameLabel)
        addSubview(articleImageView)
        
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-[v1(50)]-14-|", views: nameLabel, articleImageView)
        addConstraintsWithFormat(format: "V:|[v0(80)]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0(50)]", views: articleImageView)
    }
}
