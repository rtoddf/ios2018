import UIKit

class ArticleListScreen: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var articles:[Item] = []
    let segueIdentifier:String = "MasterToDetail"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        let jsonUrlString = "https://www.whio.com/feed?id=0face55a-4cf7-11e6-8f16-4a55d4f1e287&count=10&secure=true"
        let url = URL(string: jsonUrlString)

        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            // take care of reponses and err
            
            guard let data = data else { return }
            do {
                let feed = try JSONDecoder().decode(ApiResults.self, from: data)
                self.articles = feed.channel.item

//                for item in feed.channel.item {
//                    let article = Item()
//                    self.articles.append(article)
                // pub_date: item.pub_date?.toDateString(inputDateFormat: "EE, dd MMM YYYY HH:mm:ss z", ouputDateFormat: "hh:mm a EEEE, MMMM dd, YYYY"),
//                }

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let jsonErr {
                print("error serializing JSON:", jsonErr)
            }
            
        }.resume()
        
//        print("articles count: \(articles.count)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            let destVC = segue.destination as! ArticleViewController
            destVC.article = sender as? Item
        }
    }
}

extension ArticleListScreen: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = articles[indexPath.row]
        let cellIndentifier:String = "ArticleCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier) as! ArticleCell
        cell.setArticle(article: article)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        performSegue(withIdentifier: segueIdentifier, sender: article)
    }
}
