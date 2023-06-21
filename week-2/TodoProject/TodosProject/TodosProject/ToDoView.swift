import UIKit
import CoreData

class ToDoView: UIView { 
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var isCompletedSwitch: UISwitch!
    @IBOutlet weak var title: UILabel!
    
    var entity : NSEntityDescription?
    var managedObjectContext: NSManagedObjectContext?
    
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
    
    @IBAction func CloseButton(_ sender: UIButton) {
        closeView()
    }
    
    
    @IBAction func isCompletedSwitchToggled(_ sender: UISwitch) {
        if let currentObject = CoreDataManager.shared.getCurrentObject(){
            
            CoreDataManager.shared.updateToDoItem(currentObject, isDone: sender.isOn)
        }
    }
    
    
    private func closeView() {
        removeFromSuperview()
    }
    
    
}
