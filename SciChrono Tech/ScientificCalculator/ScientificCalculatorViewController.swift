import UIKit

class ScientificCalculatorViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var historyLabel: UILabel!  // Add history label to show calculation steps
    
    // Row 1: Trigonometric & Logarithmic Functions
    @IBOutlet weak var sinButton: UIButton!
    @IBOutlet weak var cosButton: UIButton!
    @IBOutlet weak var tanButton: UIButton!
    @IBOutlet weak var logButton: UIButton!
    @IBOutlet weak var lnButton: UIButton!
    @IBOutlet weak var sqrtButton: UIButton!

    // Row 2: Exponent, Factorial, Pi, e
    @IBOutlet weak var factorialButton: UIButton!
    @IBOutlet weak var piButton: UIButton!
    @IBOutlet weak var eButton: UIButton!
    @IBOutlet weak var expButton: UIButton!
    @IBOutlet weak var powerButton: UIButton!
    @IBOutlet weak var tenPowerButton: UIButton!

    // Row 3: AC, +/-, %, ÷, Memory Functions
    @IBOutlet weak var acButton: UIButton!
    @IBOutlet weak var plusMinusButton: UIButton!
    @IBOutlet weak var percentButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var radButton: UIButton!
    @IBOutlet weak var degButton: UIButton!

    // Row 4: Standard Calculator Keys (7,8,9,×, Memory+)
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var memoryAddButton: UIButton!

    // Row 5: Standard Calculator Keys (4,5,6,−, Memory-)
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var subtractButton: UIButton!
    @IBOutlet weak var memorySubtractButton: UIButton!

    // Row 6: Standard Calculator Keys (1,2,3,+, Memory Clear)
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var memoryClearButton: UIButton!

    // Row 7: Standard Calculator Keys (0, ., =, Memory Recall)
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var decimalButton: UIButton!
    @IBOutlet weak var equalsButton: UIButton!
    @IBOutlet weak var memoryRecallButton: UIButton!
    @IBOutlet weak var MainView: UIView!

    // MARK: - Variables
    var currentInput: String = ""
    var previousInput: String = ""
    var currentOperator: String = ""
    var isResultDisplayed = false
    var memoryValue: Double = 0.0
    var isDegrees = true  // Toggle between Degrees & Radians

    // For calculation history and result
    var firstInput: String = ""
    var secondInput: String = ""
    var answer: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = "0"
        historyLabel.text = "" // Initialize the history label
        applyCornerRadiusToBottomCorners(view: MainView, cornerRadius: 25)

    }
    
    // MARK: - Button Actions

    @IBAction func numberPressed(_ sender: UIButton) {
        guard let number = sender.titleLabel?.text else { return }
        
        if isResultDisplayed {
            currentInput = ""
            isResultDisplayed = false
        }
        
        if currentInput == "0" {
            currentInput = number
        } else {
            currentInput += number
        }

        displayLabel.text = currentInput
    }

    @IBAction func decimalPressed(_ sender: UIButton) {
        if !currentInput.contains(".") {
            currentInput += "."
            displayLabel.text = currentInput
        }
    }

    @IBAction func operatorPressed(_ sender: UIButton) {
        guard let operatorSymbol = sender.titleLabel?.text else { return }

        if !currentInput.isEmpty {
            if !previousInput.isEmpty {
                calculateResult()
            } else {
                previousInput = currentInput
                currentInput = ""
            }
        }
        currentOperator = operatorSymbol
    }

    @IBAction func equalsPressed(_ sender: UIButton) {
        calculateResult()
    }

    @IBAction func acPressed(_ sender: UIButton) {
        currentInput = ""
        previousInput = ""
        currentOperator = ""
        displayLabel.text = "0"
        historyLabel.text = ""  // Clear the history label
    }

    @IBAction func toggleSignPressed(_ sender: UIButton) {
        if let number = Double(currentInput) {
            currentInput = String(-number)
            displayLabel.text = currentInput
        }
    }

    @IBAction func percentPressed(_ sender: UIButton) {
        if let number = Double(currentInput) {
            currentInput = String(number / 100)
            displayLabel.text = currentInput
        }
    }

    @IBAction func trigonometricPressed(_ sender: UIButton) {
        guard let function = sender.titleLabel?.text, let number = Double(currentInput) else { return }
        
        let angle = isDegrees ? number * .pi / 180 : number  // Convert to Radians if needed
        var result: Double = 0
        
        switch function {
        case "sin":
            result = sin(angle)
        case "cos":
            result = cos(angle)
        case "tan":
            result = tan(angle)
        default:
            return
        }
        
        currentInput = String(result)
        displayLabel.text = currentInput
    }

    @IBAction func logarithmPressed(_ sender: UIButton) {
        guard let function = sender.titleLabel?.text, let number = Double(currentInput), number > 0 else {
            displayLabel.text = "Error"
            return
        }
        
        let result: Double = function == "log" ? log10(number) : log(number)
        currentInput = String(result)
        displayLabel.text = currentInput
    }

    @IBAction func sqrtPressed(_ sender: UIButton) {
        if let number = Double(currentInput), number >= 0 {
            currentInput = String(sqrt(number))
            displayLabel.text = currentInput
        } else {
            displayLabel.text = "Error"
        }
    }

    @IBAction func factorialPressed(_ sender: UIButton) {
        if let number = Int(currentInput), number >= 0 {
            if number > 170 {  // `Double` can safely handle up to `170!`
                displayLabel.text = "Overflow"
                return
            }
            
            let result = (1...max(number, 1)).map { Double($0) }.reduce(1, *)
            currentInput = String(format: "%.0f", result)  // Remove decimal for whole numbers
            displayLabel.text = currentInput
        } else {
            displayLabel.text = "Error"
        }
    }

    @IBAction func toggleRadiansDegrees(_ sender: UIButton) {
        isDegrees.toggle()
        
        // Change title without altering font size
        let newTitle = isDegrees ? "Deg" : "Rad"
        sender.setTitle(newTitle, for: .normal)
        
        // Set font size, ensuring it remains the same even after title change
        sender.titleLabel?.font = UIFont.systemFont(ofSize: 8, weight: .regular)
        
        // Ensure title stays in one line
        sender.titleLabel?.numberOfLines = 1
        sender.titleLabel?.lineBreakMode = .byTruncatingTail // Truncate if needed
        
        // Fix the button width to avoid resizing based on title
        sender.frame.size.width = sender.intrinsicContentSize.width + 10 // Add padding if needed

        // Convert current input if it's a valid number
        if let number = Double(currentInput), !currentInput.isEmpty {
            let convertedValue: Double
            if isDegrees {
                // Convert Radians to Degrees
                convertedValue = number * 180 / .pi
            } else {
                // Convert Degrees to Radians
                convertedValue = number * .pi / 180
            }
            
            // Format the output to avoid too many decimals
            currentInput = String(format: "%.6f", convertedValue)
            displayLabel.text = currentInput
        }
    }






    @IBAction func memoryFunctionPressed(_ sender: UIButton) {
        guard let function = sender.titleLabel?.text, let number = Double(currentInput) else { return }
        
        switch function {
        case "M+":
            memoryValue += number
        case "M-":
            memoryValue -= number
        case "MC":
            memoryValue = 0.0
        case "MR":
            currentInput = String(memoryValue)
            displayLabel.text = currentInput
        default:
            break
        }
    }

    @IBAction func piPressed(_ sender: UIButton) {
        currentInput = String(Double.pi)
        displayLabel.text = currentInput
    }

    @IBAction func ePressed(_ sender: UIButton) {
        currentInput = String(M_E)  // M_E is the constant for Euler's number
        displayLabel.text = currentInput
    }

    @IBAction func ePowerXPressed(_ sender: UIButton) {
        if let number = Double(currentInput) {
            let result = pow(M_E, number)
            currentInput = String(result)
            displayLabel.text = currentInput
        }
    }

    @IBAction func tenPowerXPressed(_ sender: UIButton) {
        if let number = Double(currentInput) {
            let result = pow(10, number)
            currentInput = String(result)
            displayLabel.text = currentInput
        }
    }
    
    // MARK: - Calculation Logic

    func calculateResult() {
        // Set firstInput and secondInput from the current operator and inputs
        firstInput = previousInput
        secondInput = currentInput

        if let firstValue = Double(firstInput), let secondValue = Double(secondInput) {
            var result: Double = 0
            
            switch currentOperator {
            case "+":
                result = firstValue + secondValue
            case "-":
                result = firstValue - secondValue
            case "x":
                result = firstValue * secondValue
            case "/":
                result = secondValue == 0 ? Double.nan : firstValue / secondValue
            case "x^y":
                result = pow(firstValue, secondValue)
            default:
                return
            }
            
            // Store the result in answer
            if result.truncatingRemainder(dividingBy: 1) == 0 {
                answer = String(Int(result))  // Display as integer if whole number
            } else {
                answer = String(result)  // Display as decimal if needed
            }

            displayLabel.text = answer
            
            // Update the history label
            let calculationHistory = "\(firstInput) \(currentOperator) \(secondInput) = \(answer)"
            historyLabel.text = calculationHistory

            // Save history with the current date in UserDefaults
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"
            let currentDate = dateFormatter.string(from: Date())
            let historyEntry = "\(currentDate) - \(calculationHistory)"
            
            // Get existing history from UserDefaults or create a new array
            var savedHistory = UserDefaults.standard.array(forKey: "ScientificCalculationHistory") as? [String] ?? [String]()
            savedHistory.append(historyEntry)
            print(historyEntry)
            
            // Save updated history back to UserDefaults with the new key
            UserDefaults.standard.set(savedHistory, forKey: "ScientificCalculationHistory")

            // Reset values for the next calculation
            previousInput = ""
            currentInput = ""
            currentOperator = ""
            isResultDisplayed = true
        }
    }

    @IBAction func btnback(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
