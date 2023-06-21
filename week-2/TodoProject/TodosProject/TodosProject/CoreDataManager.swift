import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private lazy var managedObjectContext = appDelegate.persistentContainer.viewContext
    
    
    
    func getCurrentObject() -> NSManagedObject? {
      
        let request = NSFetchRequest<NSManagedObject>(entityName: "Model")
        
        do {
            let results = try managedObjectContext.fetch(request)
            return results.first
        } catch {
            print("Failed to fetch current object: \(error)")
            return nil
        }
    }
    
    func createToDoItem(withText text: String) {
        let newTodo = NSEntityDescription.insertNewObject(forEntityName: "Model", into: managedObjectContext)
        
        let randomIndex = Int.random(in: 0..<20)
        
        newTodo.setValue(text, forKey: "value")
        newTodo.setValue(randomIndex, forKey: "indexColor")
        newTodo.setValue(UUID(), forKey: "id")
        newTodo.setValue(false, forKey: "isDone")
        
        saveContext()
    }
    
    func updateToDoItem(_ todo: NSManagedObject, isDone: Bool) {
        todo.setValue(isDone, forKey: "isDone")
        saveContext()
    }
    
    func deleteToDoItem(_ todo: NSManagedObject) {

        managedObjectContext.delete(todo)
        print("delete")
        saveContext()
    }
    
    
    func getAllToDoItems() -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Model")
        
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            return results
        } catch {
            fatalError("Failed to fetch todos: \(error)")
        }
    }
    
    
    private func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Failed to save context: \(error)")
        }
    }
}
