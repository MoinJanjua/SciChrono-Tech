import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!  // IBOutlet for the "No Data" label
    @IBOutlet weak var MainView: UIView!

    // Arrays to hold standard and scientific history entries
    var standardHistoryEntries: [(date: String, history: String)] = []
    var scientificHistoryEntries: [(date: String, history: String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        loadHistoryFromUserDefaults()

        // Set the delegate and dataSource
        historyTableView.delegate = self
        historyTableView.dataSource = self
        DispatchQueue.main.async {
            self.historyTableView.reloadData()
            
        }
        applyCornerRadiusToBottomCorners(view: MainView, cornerRadius: 25)


        // Update "No Data" label visibility
        updateNoDataLabelVisibility()
        historyTableView.separatorStyle = .singleLine  // Removes default separator
        historyTableView.backgroundColor = .clear // Ensures background is transparent

    }

    @IBAction func btnback(_ sender: Any) {
        self.dismiss(animated: true)
    }

    // MARK: - TableView DataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return standardHistoryEntries.count + scientificHistoryEntries.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < standardHistoryEntries.count {
            // Standard History Entry
            let entry = standardHistoryEntries[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "StandardCell", for: indexPath) as! StandardHistoryCell
            cell.dateLabel.text = entry.date
            cell.historyLabel.text = entry.history
            return cell
        } else {
            // Scientific History Entry
            let entry = scientificHistoryEntries[indexPath.row - standardHistoryEntries.count]
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScientificCell", for: indexPath) as! ScientificHistoryCell
            cell.scidateLabel.text = entry.date
            cell.scihistoryLabel.text = entry.history
            return cell
        }
    }

    // MARK: - TableView Editing (Delete)

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.row < standardHistoryEntries.count {
                // Remove from standard history
                standardHistoryEntries.remove(at: indexPath.row)
            } else {
                // Remove from scientific history
                scientificHistoryEntries.remove(at: indexPath.row - standardHistoryEntries.count)
            }

            // Save updated history to UserDefaults
            saveHistoryToUserDefaults()

            // Delete row with animation
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            // Update "No Data" label visibility
            updateNoDataLabelVisibility()
        }
    }

    // MARK: - Load History (Standard + Scientific)

    func loadHistoryFromUserDefaults() {
        // Clear previous entries
        standardHistoryEntries = []
        scientificHistoryEntries = []

        // Load Standard History
        if let standardHistory = UserDefaults.standard.array(forKey: "calculatorHistory") as? [String] {
            for entry in standardHistory {
                let components = entry.split(separator: "-")
                if components.count == 2 {
                    let historyText = String(components[0]).trimmingCharacters(in: .whitespaces)
                    let date = String(components[1]).trimmingCharacters(in: .whitespaces)
                    standardHistoryEntries.append((date: date, history: historyText))
                }
            }
        }

        // Load Scientific History
        if let scientificHistory = UserDefaults.standard.array(forKey: "ScientificCalculationHistory") as? [String] {
            for entry in scientificHistory {
                let components = entry.split(separator: "-")
                if components.count >= 2 {  // Adjusted for cases with date and history parts
                    let historyText = String(components[0]).trimmingCharacters(in: .whitespaces)
                    let date = String(components[1]).trimmingCharacters(in: .whitespaces)
                    scientificHistoryEntries.append((date: date, history: historyText))
                }
            }
        }

        // Reload TableView Data
        historyTableView.reloadData()

        // Update "No Data" label visibility
        updateNoDataLabelVisibility()
    }

    // MARK: - Save History

    func saveHistoryToUserDefaults() {
        // Save Standard History
        let standardHistoryArray = standardHistoryEntries.map { "\($0.history) - \($0.date)" }
        UserDefaults.standard.set(standardHistoryArray, forKey: "calculatorHistory")

        // Save Scientific History
        let scientificHistoryArray = scientificHistoryEntries.map { "\($0.history) - \($0.date)" }
        UserDefaults.standard.set(scientificHistoryArray, forKey: "ScientificCalculationHistory")
    }

    // MARK: - Update "No Data" Label Visibility

    func updateNoDataLabelVisibility() {
        if standardHistoryEntries.isEmpty && scientificHistoryEntries.isEmpty {
            // Show the "No Data" label if there are no entries
            noDataLabel.isHidden = false
        } else {
            // Hide the "No Data" label if there are any entries
            noDataLabel.isHidden = true
        }
    }
}
