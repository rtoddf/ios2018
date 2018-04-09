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
        tv.backgroundColor = .orange
//        tableView.
        return tv
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: storyCellId, for: indexPath) as! RelatedTableCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
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
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: tableView)
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
        label.text = "Sample Answer"
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews(){
        print("tableviewCell")
        
        addSubview(nameLabel)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
    }
}
