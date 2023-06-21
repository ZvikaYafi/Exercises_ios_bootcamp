
import UIKit
import CoreData

class TodoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var todoCell: UILabel!
    
    let colorArrey = CoreDataManager.shared.colorData
    
    func setup(todo: NSManagedObject) {
        
        if let indexColor = todo.value(forKey: "indexColor") as? Int ,
           let text = todo.value(forKey: "value") as? String
        {
            self.backgroundColor = colorArrey[indexColor]
            todoCell.text = text
        }
    }
}
