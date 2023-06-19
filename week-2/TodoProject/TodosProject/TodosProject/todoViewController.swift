import UIKit

class todoViewController: UIViewController {
    
    var arrOfTodo: [Todo] = []
    
    @IBOutlet weak var todoViewColection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the saved todos from UserDefaults, if available
        if let data = UserDefaults.standard.data(forKey: "TodoArray"),
           let todos = try? JSONDecoder().decode([Todo].self, from: data) {
            arrOfTodo = todos
        }
        
        // Set the data source and delegate for the collection view
        todoViewColection.dataSource = self
        todoViewColection.delegate = self
    }
    
    // alert action
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
            
            // Create a new todo with a random index of array color
            let random = Int.random(in: 0..<20)
            let newTodo = Todo(value: text, indexOFArreyColor: random)
            
            // Add the new todo to the array and reload the collection view
            self.arrOfTodo.append(newTodo)
            self.todoViewColection.reloadData()
            
            // Save the updated todos to UserDefaults
            if let encoded = try? JSONEncoder().encode(self.arrOfTodo) {
                UserDefaults.standard.set(encoded, forKey: "TodoArray" )
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension todoViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrOfTodo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "todo", for: indexPath) as! TodoCollectionViewCell
        
        // Configure the cell with the corresponding todo
        cell.setup(todo: arrOfTodo[indexPath.item])
        return cell
    }
    
    // Setting the appropriate height and width for each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing
        let adjustedWidth = collectionViewWidth - spaceBetweenCells
        
        let width: CGFloat = adjustedWidth / 2
        let height: CGFloat = 150
        
        return CGSize(width: width, height: height)
    }
}
