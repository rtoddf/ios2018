import UIKit

class Header:CategoryCell {
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = frame.width / 2
        let height = (9 / 16) * width
        
        return CGSize(width: width, height: height + 30)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let peeps = banner?.people {
            return peeps.count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // remember to cast!!!!!!
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largePersonCellId, for: indexPath) as! LargePersonCell
        cell.person = banner?.people![indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("big cell")
        guard let person = banner?.people![indexPath.item] else { return }
//        print("person: \(person)")
        featuredPersonController?.showPersonDetailForPerson(person: person)
    }
    
    override func setupViews() {
        peopleCollectionView.register(LargePersonCell.self, forCellWithReuseIdentifier: largePersonCellId)
        
        peopleCollectionView.dataSource = self
        peopleCollectionView.delegate = self
        
        addSubview(peopleCollectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: peopleCollectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: peopleCollectionView)
    }
}

class CategoryCell:BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var featuredPersonController: FeaturedController?
    
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
    
    var banner:Banner? {
        didSet {
            guard let name = banner?.name else { return }
            categoryTitleLabel.text = name
            
            peopleCollectionView.reloadData()
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let person = category?.people![indexPath.item] else { return }
        featuredPersonController?.showPersonDetailForPerson(person: person)
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
    
    override func setupViews(){
        backgroundColor = .white
        
        addSubview(peopleCollectionView)
        peopleCollectionView.dataSource = self
        peopleCollectionView.delegate = self
        peopleCollectionView.register(PersonCell.self, forCellWithReuseIdentifier: personCellId)
        peopleCollectionView.register(LargePersonCell.self, forCellWithReuseIdentifier: largePersonCellId)
        
        addSubview(categoryTitleLabel)
        addSubview(dividerBarView)
        
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: categoryTitleLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: peopleCollectionView)
        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: dividerBarView)
        addConstraintsWithFormat(format: "V:|-4-[v2(30)]-4-[v0][v1(0.5)]|", views: peopleCollectionView, dividerBarView, categoryTitleLabel)
    }
}

class LargeCategoryCell:CategoryCell {
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = frame.height - 30
        let width = height * (16 / 9)
        return CGSize(width: width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // remember to cast!!!!!!
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largePersonCellId, for: indexPath) as! LargePersonCell
        cell.person = category?.people![indexPath.item]
        return cell
    }
}
