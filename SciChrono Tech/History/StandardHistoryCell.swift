import UIKit

class StandardHistoryCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        // Style the container view
      
        containerView.layer.borderColor = UIColor.systemYellow.cgColor
        containerView.layer.masksToBounds = true
        containerView.layer.borderWidth = 1
//        containerView.backgroundColor = .clear

    }
}
