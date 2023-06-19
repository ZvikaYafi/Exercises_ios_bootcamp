import UIKit

class todoViewController: UIViewController {
    
    var arrOfTodo: [Todo] = []
    
    @IBOutlet weak var todoViewColection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoViewColection.dataSource = self
        todoViewColection.delegate = self
        
        if let data = UserDefaults.standard.data(forKey: "TodoArray"),
           let todos = try? JSONDecoder().decode([Todo].self, from: data) {
            arrOfTodo = todos
        }
    }
    
    @IBAction func AddTodo(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Title", message: nil, preferredStyle: .alert)
        
        alert.addTextField()
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self, weak alert] (_) in
            guard let self = self, let textField = alert?.textFields?.first,
                  let text = textField.text,
                  !text.isEmpty
            else {
                return
            }
            
            let random = Int.random(in: 0..<20)
            let newTodo = Todo(value: text, indexOFArreyColor: random)
            
            self.arrOfTodo.append(newTodo)
            self.todoViewColection.reloadData()
            
            if let encoded = try? JSONEncoder().encode(arrOfTodo) {
                UserDefaults.standard.set(encoded, forKey: "TodoArray" )
            }
        }))
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension todoViewController :UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrOfTodo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "todo", for: indexPath) as! TodoCollectionViewCell
        
        cell.setup(todo: arrOfTodo[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewWidth = collectionView.bounds.width
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing
        
        let adjustrdWidth = collectionViewWidth - spaceBetweenCells
        
        let width :CGFloat = adjustrdWidth /  2
        
        let height :CGFloat = 150
        
        return CGSize(width: width, height: height)
    }
    
    
    
}


