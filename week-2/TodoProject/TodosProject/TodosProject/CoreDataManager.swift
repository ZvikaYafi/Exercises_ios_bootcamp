import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private lazy var managedObjectContext = appDelegate.persistentContainer.viewContext
    
    let colorData = [#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1), #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1),
                     #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1), #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1), #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1), #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)]

    // create a new todo and save in core data
    func createToDoItem(withText text: String) {
        let newTodo = NSEntityDescription.insertNewObject(forEntityName: "Model", into: managedObjectContext)
        
        let randomIndex = Int.random(in: 0..<colorData.count)
        
        newTodo.setValue(text, forKey: "value")
        newTodo.setValue(randomIndex, forKey: "indexColor")
        newTodo.setValue(UUID(), forKey: "id")
        newTodo.setValue(false, forKey: "isDone")
        
        saveContext()
    }
    
    // update todo and save
    func updateToDoItem(_ todo: NSManagedObject, isDone: Bool) {
        todo.setValue(isDone, forKey: "isDone")
        
        saveContext()
    }
    
    // delete todo and save
    func deleteToDoItem(_ todo: NSManagedObject) {
        managedObjectContext.delete(todo)
        
        saveContext()
    }
    
    // get all todos object from Core Data
    func getAllToDoItems() -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Model")
        
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            return results
        } catch {
            fatalError("Failed to fetch todos: \(error)")
        }
    }
    
    // sort arrey by true or false task
    func sortByIsDone(todoArray: [NSManagedObject]) -> [NSManagedObject] {
        return todoArray.sorted { (todo1, todo2) -> Bool in
            let isDone1 = todo1.value(forKey: "isDone") as? Bool ?? false
            let isDone2 = todo2.value(forKey: "isDone") as? Bool ?? false
            
            if isDone1 == isDone2 {
                return false
            } else if isDone1 {
                return false
            } else {
                return true
            }
        }
    }

    // save todo 
    private func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Failed to save context: \(error)")
        }
    }
}
