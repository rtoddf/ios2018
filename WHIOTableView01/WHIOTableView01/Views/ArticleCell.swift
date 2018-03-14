import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var articleThumbnailImage: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var playButton: UIImageView!
    
    func setArticle(article: Item) {
        articleTitleLabel.text = article.title

        var imageUrl:String = ""
        
        if article.images != nil {
            imageUrl = article.images![0].url!
        } else if article.videos != nil {
            imageUrl = article.videos![0].image.url!
            playButton.image = #imageLiteral(resourceName: "playbutton")
        } else {
            imageUrl = "https://www.whio.com/assets/images/whio-placeholder.png"
        }
        
        articleThumbnailImage.loadImageUsingUrlString(imageUrl: imageUrl)
    }
}
