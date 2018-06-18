import UIKit

class DailyConditionsCell:BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var dailyConditions:[Day]?
    let dayCellId = "dayCellId"
    
//    var dailyConditions:[Day]? {
//        didSet {
////            guard let tempf = currentConditions?.tempF else { return }
////            guard let sky = currentConditions?.sky else { return }
////            tempLabel.text = String(tempf) + "°"
////            skyLabel.text = sky
//        }
//    }
    
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        layout.scrollDirection = .horizontal
        return cv
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = dailyConditions?.count {
            return count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCellId", for: indexPath) as! DayCell
        
//        if let image = article?.media![indexPath.item].path,
//            let title = article?.media![indexPath.item].title,
//            let caption = article?.media![indexPath.item].caption,
//            let credit = article?.media![indexPath.item].credit {
//
//            cell.articleImageView.loadImageUsingUrlString(imageUrl: image)
//            let tappy = MyTapGesture(target: self, action: #selector(self.animateView))
//            tappy.title = title
//            tappy.caption = caption
//            tappy.credit = credit
//
//            cell.articleImageView.addGestureRecognizer(tappy)
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = frame.width * 0.25
        let height = width
        
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func setupViews() {
        super.setupViews()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: dayCellId)
        
        let weatherFeed = "http://weather.cmgdigital.com/USOH0245/"
        Weather.downloadDailyWeather(feedUrl: weatherFeed) { dailyConditions in
            print("dailyConditions in view, inside the callback: \(dailyConditions)")
            self.dailyConditions = dailyConditions
            
            self.collectionView.reloadData()
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
//        collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.animateView)))
        
//        addSubview(headerLabel)
        addSubview(collectionView)
        
//        addConstraintsWithFormat(format: "H:|-14-[v0]-14-|", views: headerLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
    }
    
}

class DayCell:BaseCell {
//    let articleImageView:UIImageView = {
//        let iv = UIImageView()
//        iv.contentMode = .scaleAspectFit
//        iv.clipsToBounds = true
//        iv.backgroundColor = UIColor(hexString: "#333")
//        iv.isUserInteractionEnabled = true
//        return iv
//    }()
    
    let dateLabel:UILabel = {
        let label = UILabel()
        label.text = "Mon Jun 8"
        label.font = .weatherDailyDateFont
        label.textAlignment = .center
        return label
    }()
    
    let tempLabel:UILabel = {
        let label = UILabel()
        label.text = "85°"
        label.font = .weatherDailyTempFont
        label.textAlignment = .center
        return label
    }()
    
    let precipChanceLabel:UILabel = {
        let label = UILabel()
        label.text = "Rain: 20%"
        label.font = .weatherDailyDateFont
        label.textAlignment = .center
        return label
    }()
    
    override func setupViews() {
        super.setupViews()

        addSubview(dateLabel)
        addSubview(tempLabel)
        addSubview(precipChanceLabel)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: dateLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: tempLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: precipChanceLabel)
        
        
        addConstraintsWithFormat(format: "V:|[v0]-4-[v1]-4-[v2]", views: dateLabel, tempLabel, precipChanceLabel)
    }
}








