import UIKit
import CoreData

class TodoViewController: UIViewController {
    
    var arrayOfTodo: [NSManagedObject] = []
    private var managedObjectContext: NSManagedObjectContext?
    var entity : NSEntityDescription?
    
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
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
        guard let context = managedObjectContext else {return}
        
        entity = NSEntityDescription.entity(forEntityName: "Model", in: context)
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Model")
        
        do{
            let result = try context.fetch(request)
            arrayOfTodo = result
            todoViewColection.reloadData()
            
        }catch {
            fatalError("error")
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
        
        guard let context = managedObjectContext,
              let entity = entity else {return}

        
        // Create a new todo with a random index of array color
        let random = Int.random(in: 0..<20)
        let newTodo = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        newTodo.setValue(text, forKey: "value")
        newTodo.setValue(random, forKey: "indexOFArreyColor")
        newTodo.setValue(UUID(), forKey: "id")
        
        // Add the new todo to the array and reload the collection view
        // Save the updated todos to UserDefaults

        do {
            try context.save()
            arrayOfTodo.append(newTodo)
            todoViewColection.reloadData()
        }catch {
            fatalError("data not saved")
        }
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
}
