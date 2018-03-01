import UIKit

class Header:CategoryCell {
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (frame.height - 30) * (16 / 9)
        return CGSize(width: width, height: frame.height - 30)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // remember to cast!!!!!!
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largePersonCellId, for: indexPath) as! LargePersonCell
        cell.person = category?.people![indexPath.item]
        return cell
    }
    
    override func setupViews() {
        super.setupViews()
        
        peopleCollectionView.dataSource = self
        peopleCollectionView.delegate = self
        
        addSubview(peopleCollectionView)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: [
            "v0": peopleCollectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: [
            "v0": peopleCollectionView]))
    }
}

class CategoryCell:UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
//    var person:[Person]?
    let personCellId = "personCellId"
    let largePersonCellId = "largePersonCellId"
    
    var category:Category? {
        didSet {
            guard let name = category?.name else { return }
            categoryTitleLabel.text = name
            
            peopleCollectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let peopleCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = true
        cv.backgroundColor = .clear
        return cv
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let peeps = category?.people {
            return peeps.count
        }
        return 0        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // remember to cast!!!!!!
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: personCellId, for: indexPath) as! PersonCell
        cell.person = category?.people![indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: frame.height - 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7)
    }
    
    let categoryTitleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Actors"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor(hexString: "#333333")
        return label
    }()
    
    let dividerBarView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hexString: "#baba71")
        return view
    }()
    
    func setupViews(){
        backgroundColor = .white
        
        addSubview(peopleCollectionView)
        peopleCollectionView.dataSource = self
        peopleCollectionView.delegate = self
        peopleCollectionView.register(PersonCell.self, forCellWithReuseIdentifier: personCellId)
        peopleCollectionView.register(LargePersonCell.self, forCellWithReuseIdentifier: largePersonCellId)
        
        addSubview(categoryTitleLabel)
        addSubview(dividerBarView)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]-14-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": categoryTitleLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": peopleCollectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]-14-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dividerBarView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-4-[v2(30)]-4-[v0][v1(0.5)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": peopleCollectionView, "v1": dividerBarView, "v2": categoryTitleLabel]))
    }
}

class LargeCategoryCell:CategoryCell {
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (frame.height - 30) * (16 / 9)
        return CGSize(width: width, height: frame.height - 30)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // remember to cast!!!!!!
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largePersonCellId, for: indexPath) as! LargePersonCell
        cell.person = category?.people![indexPath.item]
        return cell
    }
}
