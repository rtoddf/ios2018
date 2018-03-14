import UIKit
import WebKit

class ArticleViewController: UIViewController {
    @IBOutlet weak var articleLeadImage: UIImageView!
    @IBOutlet weak var articleHeadlineLabel: UILabel!
    @IBOutlet weak var playButton: UIImageView!
    @IBOutlet weak var articlePubDateLabel: UILabel!
    @IBOutlet weak var articleAuthorLabel: UILabel!
    @IBOutlet weak var fullTextWebView: WKWebView!
    
    var article:Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {        
        articleHeadlineLabel.text = article?.title
        guard let pubdate = article?.pub_date?.toDateString(inputDateFormat: "EE, dd MMM YYYY HH:mm:ss z", ouputDateFormat: "hh:mm a EEEE, MMMM dd, YYYY") else { return }
        articlePubDateLabel.text = "Posted: " + pubdate
        articleAuthorLabel.text = "By " + (article?.author)!
        
        guard let full_text = article?.full_text else { return }
        fullTextWebView.loadHTMLString(full_text.wrapHTML(), baseURL: nil)
        
        
        // https://www.appcoda.com/webkit-framework-intro/
        // http://delovski.net/webkitwebview/
//        fullTextWebView.translatesAutoresizingMaskIntoConstraints = false
//        let height = NSLayoutConstraint(item: fullTextWebView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0)
//        let width = NSLayoutConstraint(item: fullTextWebView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
//        view.addConstraints([height])
        
        let htmlViewHeight = fullTextWebView.scrollView.contentSize.height
        print("htmlViewHeight: \(htmlViewHeight)")
        
        var imageUrl:String = ""
        
        if article?.images != nil {
            imageUrl = (article?.images![0].url!)!
        } else if article?.videos != nil {
            imageUrl = (article?.videos![0].image.url!)!
            playButton.image = #imageLiteral(resourceName: "playbutton")
        } else {
            imageUrl = "https://www.whio.com/assets/images/whio-placeholder.png"
        }
        
        articleLeadImage.loadImageUsingUrlString(imageUrl: imageUrl)
    }
}
