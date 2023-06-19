import UIKit

class todoViewController: UIViewController {
    
    var arrayOfTodo: [Todo] = []
    
    @IBOutlet weak var todoViewColection: UICollectionView!
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    //MARK: - IBActions
    
    // alert action
    @IBAction func AddTodo(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Title", message: nil, preferredStyle: .alert)
        
        alert.addTextField()
        
        insertAddAction(for: alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - UI Methods
    
    private func setupUI() {
        
        // Load the saved todos from UserDefaults, if available
        if let data = UserDefaults.standard.data(forKey: "TodoArray"),
           let todos = try? JSONDecoder().decode([Todo].self, from: data) {
            arrayOfTodo = todos
        }
        
        // Set the data source and delegate for the collection view
        todoViewColection.dataSource = self
        todoViewColection.delegate = self
    }
    
    private func insertAddAction(for alert: UIAlertController) {
        
        let action = UIAlertAction(title: "Add", style: .default) { [weak self] action in
            
            guard let self = self,
                  let textfield = alert.textFields?.first,
                  let text = textfield.text, !text.isEmpty else {
                return
            }
            
            createToDo(for: text)
        }
        
        alert.addAction(action)
    }
    
    //MARK: - Data Methods
    
    private func createToDo(for text: String) {
        // Create a new todo with a random index of array color
        let random = Int.random(in: 0..<20)
        let newTodo = Todo(value: text, indexOFArreyColor: random)
        
        // Add the new todo to the array and reload the collection view
        arrayOfTodo.append(newTodo)
        todoViewColection.reloadData()
        
        // Save the updated todos to UserDefaults
        if let encoded = try? JSONEncoder().encode(arrayOfTodo) {
            UserDefaults.standard.set(encoded, forKey: "TodoArray" )
        }
    }
    
}

extension todoViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfTodo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "todo", for: indexPath) as! TodoCollectionViewCell
        
        // Configure the cell with the corresponding todo
        cell.setup(todo: arrayOfTodo[indexPath.item])
        return cell
    }
    
    // Setting the appropriate height and width for each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize(width: 0, height: 0)
        }
        
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing
        let adjustedWidth = collectionViewWidth - spaceBetweenCells
        
        let width: CGFloat = adjustedWidth / 2
        let height: CGFloat = 150
        
        return CGSize(width: width, height: height)
    }
}
