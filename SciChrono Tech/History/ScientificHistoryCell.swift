import UIKit

class ScientificHistoryCell: UITableViewCell {

    @IBOutlet weak var scidateLabel: UILabel!
    @IBOutlet weak var scihistoryLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        // Different style for scientific cell (optional)
        
        containerView.layer.borderColor = UIColor.systemYellow.cgColor
        containerView.layer.borderWidth = 1
        containerView.layer.masksToBounds = true
//        containerView.backgroundColor = 

    }
}
