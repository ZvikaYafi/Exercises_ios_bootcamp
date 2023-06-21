import UIKit
import CoreData

class ToDoView: UIView { 
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var isCompletedSwitch: UISwitch!
    @IBOutlet weak var title: UILabel!
    var toDo: NSManagedObject?
    
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

    
    @IBAction func isCompletedSwitchToggled(_ sender: UISwitch) {
        guard let toDo = self.toDo else { return }
              print(sender.isOn)
              //toDo.setValue(sender.isOn, forKey: "isDone")
 
    }
    

}

