
import UIKit
import CoreData

class TodoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var todoCell: UILabel!
    @IBOutlet weak var checkmark: UIImageView!
    
    let colorArrey = CoreDataManager.shared.colorData
    
    func setup(todo: NSManagedObject) {
        
        if let indexColor = todo.value(forKey: "indexColor") as? Int ,
           let text = todo.value(forKey: "value") as? String
        {
            if (todo.value(forKey: "isDone") as? Bool == true)  {
                checkmark.isHidden = false
                self.backgroundColor = colorArrey[indexColor]
                todoCell.text = text
            } else {
                checkmark.isHidden = true
                self.backgroundColor = colorArrey[indexColor]
                todoCell.text = text
            }
            
        }
    }
}
