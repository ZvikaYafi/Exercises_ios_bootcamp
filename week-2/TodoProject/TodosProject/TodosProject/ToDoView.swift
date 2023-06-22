import UIKit
import CoreData

class ToDoView: UIView { 
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var isCompletedSwitch: UISwitch!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    var todo: NSManagedObject?
    var reloadData : (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit(){
        let viewFromXib = Bundle.main
            .loadNibNamed("ToDoView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
    
    // button of close view
    @IBAction func CloseButton(_ sender: UIButton) {
        reloadData?()
        removeFromSuperview()
    }
    
    // butoon type switch that update todo object in Core Data
    @IBAction func isCompletedSwitchToggled(_ sender: UISwitch) {
        if let currentObject = todo {
            CoreDataManager.shared.updateToDoItem(currentObject, isDone: sender.isOn)
        }
    }
}
