import UIKit

class StandardcalculatorViewController: UIViewController {

    // IBOutlet connections for number buttons (0-9)
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    
    // IBOutlet for other buttons
    @IBOutlet weak var buttonAC: UIButton!
    @IBOutlet weak var buttonPlusMinus: UIButton!
    @IBOutlet weak var buttonPercent: UIButton!
    @IBOutlet weak var buttonDivide: UIButton!
    @IBOutlet weak var buttonMultiply: UIButton!
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var buttonSubtract: UIButton!
    @IBOutlet weak var buttonEquals: UIButton!
    @IBOutlet weak var buttonDecimal: UIButton!
    @IBOutlet weak var MainView: UIView!

    
    // IBOutlet for the display label
    @IBOutlet weak var displayLabel: UILabel!
    
    // IBOutlet for the history label
    @IBOutlet weak var historyLabel: UILabel!
    
    var currentInput: String = "" // Holds the current input as a string
    var previousInput: String = "" // Holds the first number for the operation
    var secondInput: String = ""  // Holds the second number for the operation
    var currentOperator: String = "" // Holds the current operator
    var isResultDisplayed = false // Flag to check if result is displayed

    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = "0"
        historyLabel.text = "" // Initialize the history label
        applyCornerRadiusToBottomCorners(view: MainView, cornerRadius: 25)

    }
    
    // MARK: - Button Actions

    @IBAction func numberPressed(_ sender: UIButton) {
        guard let number = sender.titleLabel?.text else { return }

        // If the result was displayed previously, reset the display
        if isResultDisplayed {
            currentInput = ""
            isResultDisplayed = false
        }

        // Avoid starting with multiple zeros
        if currentInput == "0" {
            currentInput = number
        } else {
            currentInput += number
        }

        displayLabel.text = currentInput

        // Update the history label with first input, operator and current input
        if !previousInput.isEmpty && !currentOperator.isEmpty {
            historyLabel.text = "\(previousInput) \(currentOperator) \(currentInput)"
        }
    }

    // Decimal point button
    @IBAction func decimalPressed(_ sender: UIButton) {
        // Prevent adding multiple decimal points
        if !currentInput.contains(".") {
            currentInput += "."
            displayLabel.text = currentInput
        }
    }

    // Operator buttons (+, -, x, /)
    @IBAction func operatorPressed(_ sender: UIButton) {
        guard let operatorSymbol = sender.titleLabel?.text else { return }

        // If an operator is already selected and the current input is not empty, save the first input and operator
        if !currentInput.isEmpty {
            if previousInput.isEmpty {
                previousInput = currentInput
                currentInput = ""
            } else {
                secondInput = currentInput // Store the second input
                calculateResult()  // Calculate if we already have both inputs
            }
        }

        // Store the current operator
        currentOperator = operatorSymbol
        
        // Update the history label with the current input and operator
        historyLabel.text = "\(previousInput) \(currentOperator)"
    }

    // AC button (clear everything)
    @IBAction func acPressed(_ sender: UIButton) {
        currentInput = ""
        previousInput = ""
        secondInput = ""
        currentOperator = ""
        displayLabel.text = "0"
        historyLabel.text = "" // Clear the history label
    }

    // +/- button (toggle sign)
    @IBAction func toggleSignPressed(_ sender: UIButton) {
        if let currentText = displayLabel.text, let number = Double(currentText) {
            currentInput = String(-number)
            displayLabel.text = currentInput
        }
    }

    // % button (percentage)
    @IBAction func percentPressed(_ sender: UIButton) {
        if let currentText = displayLabel.text, let number = Double(currentText) {
            currentInput = String(number / 100)
            displayLabel.text = currentInput
        }
    }

    @IBAction func btnback(_ sender: Any) {
        self.dismiss(animated: true)
    }

    // = button (calculate result)
    @IBAction func equalsPressed(_ sender: UIButton) {
        secondInput = currentInput // Save the second input before calculating
        calculateResult()
    }

    // MARK: - Helper Methods

    // Perform the calculation based on the current operator
    func calculateResult() {
        if let previousValue = Double(previousInput), let currentValue = Double(secondInput) {
            var result: Double = 0

            switch currentOperator {
            case "+":
                result = previousValue + currentValue
            case "-":
                result = previousValue - currentValue
            case "x":
                result = previousValue * currentValue
            case "/":
                if currentValue != 0 {
                    result = previousValue / currentValue
                } else {
                    displayLabel.text = "Error"
                    return
                }
            default:
                return
            }

            // Check if the result is a whole number and remove the decimal point if true
            if result == floor(result) {
                currentInput = String(Int(result))  // Remove decimal point for whole numbers
            } else {
                currentInput = String(result)
            }

            displayLabel.text = currentInput
            
            // Update the history label with the full expression (first number, operator, second number, result)
            historyLabel.text = "\(previousInput) \(currentOperator) \(secondInput) = \(currentInput)"

            // Save the history to UserDefaults
            saveHistoryToUserDefaults()

            // Reset for next operation
            previousInput = ""
            secondInput = ""
            currentOperator = ""
            isResultDisplayed = true
        }
    }

    // Save the history to UserDefaults, including the current date
    func saveHistoryToUserDefaults() {
        let historyText = historyLabel.text ?? ""
        let currentDate = getCurrentDate()
        let fullHistory = "\(historyText) - \(currentDate)" // Append date to history

        var history = UserDefaults.standard.array(forKey: "calculatorHistory") as? [String] ?? [String]()
        history.append(fullHistory)
        UserDefaults.standard.set(history, forKey: "calculatorHistory")
    }

    // Helper method to get the current date as a string
    func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: Date())
    }
}
