import UIKit

class ViewController: UIViewController  {
    
    var titles: [String]?
    
    @IBOutlet weak var titleTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        titleTable.delegate = self
        titleTable.dataSource = self
        
        PostsManager.shared.fetchPosts() { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.titles = PostsManager.shared.getAllTitle()
                    self.titleTable.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
}


extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "title", for: indexPath)
        cell.textLabel?.text = titles?[indexPath.row] ?? ""
        
        return cell
    }
}
