import UIKit
import CoreData

class TodoViewController: UIViewController {
    
    var arrayOfTodo: [NSManagedObject] = []
    var entity : NSEntityDescription?
    private var managedObjectContext: NSManagedObjectContext?
    @IBOutlet weak var todoViewColection: UICollectionView!
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - IBActions
    
    // alert action
    @IBAction func addTodo(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Title", message: nil, preferredStyle: .alert)
        alert.addTextField()
        insertAddAction(for: alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - UI Methods
    
    private func setupUI() {
        
        // import all object from CoreDataManager
        arrayOfTodo = CoreDataManager.shared.getAllToDoItems()
        
        // Set the data source and delegate for the collection view
        todoViewColection.dataSource = self
        todoViewColection.delegate = self
    }
    
    private func insertAddAction(for alert: UIAlertController) {
        
        let action = UIAlertAction(title: "Add", style: .default) { action in
            
            guard  let textfield = alert.textFields?.first,
                   let text = textfield.text, !text.isEmpty else {return}
            
            let dataManeger = CoreDataManager.shared
            
            // save todo in CoreData
            dataManeger.createToDoItem(withText: text)
            
            // Import updated array and sort by isDone
            self.arrayOfTodo = dataManeger.sortByIsDone(todoArray: dataManeger.getAllToDoItems())
            self.todoViewColection.reloadData()
        }
        alert.addAction(action)
    }
    
}

extension TodoViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
    
    //MARK: - Cell Click Handling
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let todo = arrayOfTodo[indexPath.item]
        showToDoView(todo: todo)
    }
    
    private func showToDoView(todo: NSManagedObject) {
        
        // Creating an instance for view
        let toDoView = ToDoView(frame: CGRect(x: 100, y: 300, width: 200, height: 200))
        toDoView.title.text = todo.value(forKey: "value") as? String
        toDoView.isCompletedSwitch.isOn = todo.value(forKey: "isDone") as? Bool ?? false
        toDoView.todo = todo
        
        self.view.addSubview(toDoView)
    }
}


